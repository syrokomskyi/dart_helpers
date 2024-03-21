// !Deprecated: Use https://pub.dev/packages/logger instead.
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer' as dev show log;

import '../dart_helpers.dart';

@Deprecated('Use Logger instead.')
var logUsePrint = true;

@Deprecated('Use Logger instead.')
var logShowSymbolInsteadOfLetter = true;

const _logPrintTruncateLength = 300;

@Deprecated('Use Logger instead.')
enum LogType {
  undefined('?', '❔', -1),
  info('i', 'ℹ️', 0 * deltaLevel),
  warning('w', '⚠️', 1 * deltaLevel),
  error('e', '⭕', 2 * deltaLevel);

  const LogType(this.letter, this.symbol, this.level)
      : assert(letter.length != 0),
        assert(symbol.length != 0),
        assert(level >= -1 && level < 3 * deltaLevel);

  static const deltaLevel = 1000;

  static int get levelMax => error.level + deltaLevel;

  final String letter;
  final String symbol;
  final int level;

  @override
  String toString() => symbol;
}

@Deprecated('Use Logger instead.')
extension on int {
  LogType get type {
    if (this >= LogType.info.level && this < LogType.warning.level) {
      return LogType.info;
    }

    if (this >= LogType.warning.level && this < LogType.error.level) {
      return LogType.warning;
    }

    if (this >= LogType.error.level && this < LogType.levelMax) {
      return LogType.error;
    }

    return LogType.undefined;
  }
}

@Deprecated('Use Logger instead.')
void logi(
  Object? o, {
  DateTime? time,
  int? sequenceNumber,
  int deltaLevel = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) =>
    _logi(
      o,
      time: time,
      sequenceNumber: sequenceNumber,
      deltaLevel: deltaLevel,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );

void _logi(
  Object? o, {
  DateTime? time,
  int? sequenceNumber,
  int deltaLevel = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  final level = LogType.info.level + deltaLevel;
  assert(level >= LogType.info.level && level < LogType.warning.level);

  _plog(
    o,
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: name,
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}

@Deprecated('Use Logger instead.')
void logw(
  Object? o, {
  DateTime? time,
  int? sequenceNumber,
  int deltaLevel = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  final level = LogType.warning.level + deltaLevel;
  assert(level >= LogType.warning.level && level < LogType.error.level);

  _plog(
    o,
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: name,
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}

@Deprecated('Use Logger instead.')
void loge(
  Object? o, {
  DateTime? time,
  int? sequenceNumber,
  int deltaLevel = 0,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  final level = LogType.error.level + deltaLevel;
  assert(level >= LogType.error.level && level <= LogType.levelMax);

  _plog(
    o,
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: name,
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}

void _plog(
  Object? o, {
  DateTime? time,
  int? sequenceNumber,
  required int level,
  String name = '',
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!logUsePrint) {
    dev.log(
      '$o',
      time: time,
      sequenceNumber: sequenceNumber,
      level: level,
      name: name,
      zone: zone,
      error: error,
      stackTrace: stackTrace,
    );
    return;
  }

  final prefix = logShowSymbolInsteadOfLetter
      ? level.type.symbol
      : '${level.type.letter})';
  final s = '$o';
  var r = '$prefix ${s.abbreviate(_logPrintTruncateLength)}';
  if (name.isNotEmpty) {
    r = '$name $r';
  }
  if (zone != null) {
    r = '$zone $r';
  }
  if (error != null) {
    r = '$r $error';
  }
  if (stackTrace != null) {
    r = '$r $stackTrace';
  }
  if (time != null) {
    r = '${time.toIso8601String()} $r';
  }
  if (sequenceNumber != null) {
    r = '$sequenceNumber $r';
  }

  print(r);
}

@Deprecated('Use Logger instead.')
extension Log on Object {
  @Deprecated('Use Logger instead.')
  void logi({
    DateTime? time,
    int? sequenceNumber,
    int deltaLevel = 0,
    String name = '',
    Zone? zone,
    Object? error,
    StackTrace? stackTrace,
  }) =>
      _logi(
        toString(),
        time: time,
        sequenceNumber: sequenceNumber,
        deltaLevel: deltaLevel,
        name: name,
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );
}
