import 'dart:async';
import 'dart:developer' as dev show log;

import 'extensions/string_ext.dart';

const usePrint = true;

const logLevelMin = 0;

const logInfoLevel = 0;
const logWarningLevel = 500;
const logErrorLevel = 1500;

const logLevelMax = 2000;

const _logPrintTruncateLength = 300;

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
  final level = logInfoLevel + deltaLevel;
  assert(level >= logLevelMin && level < logWarningLevel);

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
  final level = logWarningLevel + deltaLevel;
  assert(level >= logWarningLevel && level < logErrorLevel);

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
  final level = logErrorLevel + deltaLevel;
  assert(level >= logErrorLevel && level <= logLevelMax);

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
  if (!usePrint) {
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

  var letter = 'i';
  if (level >= logWarningLevel) {
    letter = 'w';
  }
  if (level >= logErrorLevel) {
    letter = 'e';
  }

  final s = '$o';
  var r = '$letter) ${s.truncate(_logPrintTruncateLength)}';
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

extension Log on Object {
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
