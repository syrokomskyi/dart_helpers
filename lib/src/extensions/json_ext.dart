import 'dart:convert' as convert;

import 'package:vector_math/vector_math_64.dart';

import '../classes/jsons.dart';
import '../classes/size.dart';
import '../constants/string.dart';
import 'string_ext.dart';

extension CleanProto3JsonExt on JsonMap {
  /// Replace all value of fields with "key-named" value to [replacer].
  Map<String, dynamic> blured({
    List<String> nameContains = const <String>[
      'key',
      'passw',
      'psw',
      'secret',
    ],
    String replacer = '*',
  }) =>
      map((k, v) {
        var r = v;
        if (v is String) {
          if (nameContains
              .firstWhere(
                (nc) => k.contains(nc),
                orElse: () => '',
              )
              .isNotEmpty) {
            r = v.replaceAll(RegExp(r'.'), replacer);
          }
        }

        return MapEntry(k, r);
      });

  /// Removes all empty fields. The "empty fields" according to Proto3:
  /// https://protobuf.dev/programming-guides/proto3/#default
  /// !) Pay attention on the nested maps. See tests.
  Map<String, dynamic> get jsonWithSignificantFields => map((k, v) =>
      MapEntry(k, v is Map<String, dynamic> ? v.jsonWithSignificantFields : v))
    ..removeWhere((k, v) =>
        (v == null) ||
        (v is bool && !v) ||
        (v is int && v == 0) ||
        (v is double && (v == 0.0 || v == -0.0)) ||
        (v is String && v.isEmpty) ||
        (v is Enum && v.index == 0) ||
        (v is List && v.isEmpty) ||
        (v is Map && v.isEmpty) ||
        (v is Set && v.isEmpty) ||
        false);

  String get sJsonWithSignificantFields => '$jsonWithSignificantFields';

  /// Same [bittenOf] but for the each string into the map (json).
  Map<String, dynamic> bittenOf(int begin, int end, [String replacer = '..']) =>
      map((k, v) {
        late final dynamic r;
        if (v is String) {
          r = v.bittenOf(begin, end, replacer);
        } else if (v is Map<String, dynamic>) {
          r = v.bittenOf(begin, end, replacer);
        } else if (v is List<String>) {
          r = v.bittenOf(begin, end, replacer);
        } else if (v is Set<String>) {
          r = v.bittenOf(begin, end, replacer);
        } else {
          r = v;
        }

        return MapEntry(k, r);
      });
}

/// See [ObjectJsonExt.toEncodable].
extension SizeJsonExt on Size {
  List<int> get json => [width.round(), height.round()];
}

/// See [ObjectJsonExt.toEncodable].
extension Vector2JsonExt on Vector2 {
  List<double> get json => [x, y];
}

/// See [SizeJsonExt], [Vector2JsonExt].
extension ObjectJsonExt on Object {
  /// Returns formatted JSON in string.
  String get sjson => jsonEncoder(this, toEncodable: toEncodable);

  /// JSON in one line string.
  String get sjsonInLine =>
      jsonEncoder(this, indent: '', toEncodable: toEncodable);

  /// JSON in one line string without wrappers.
  String get sjsonInLineWithoutWrappers => sjsonInLine.sjsonWithoutWrappers;

  /// For encode the specific objects.
  static Object toEncodable(dynamic o) {
    if (o is Size) {
      return o.json;
    }

    if (o is Vector2) {
      return o.json;
    }

    return '$o';
  }

  static String s(dynamic v) => v == null ? 'null' : (v as Object).sjson;
}

extension StringJsonExt on String {
  JsonList get jsonList => jsonDecoder(this) as JsonList;

  JsonMap get jsonMap => jsonDecoder(this) as JsonMap;

  /// !) All whitespaces and newlines with edges will be removed.
  String get sjsonWithoutWrappers {
    final s = trim();
    if (s.startsWith('{')) {
      return _sjsonWithoutWrappers('{');
    }

    if (s.startsWith('[')) {
      return _sjsonWithoutWrappers('[');
    }

    if (s.startsWith('"')) {
      return _sjsonWithoutWrappers('"');
    }

    return s;
  }

  /// [beginWrapper] The first symbol of wrapped string.
  String _sjsonWithoutWrappers(String beginWrapper) {
    assert(beginWrapper.isNotEmpty, 'Wrapper should be defined.');

    var s = replaceFirst(beginWrapper, '');
    s = s.substring(0, s.length - beginWrapper.length);
    final lines = const convert.LineSplitter().convert(s);
    var r = lines;
    if (lines.length >= 2) {
      // take the count of spaces from the second line
      final leadingSpaces = lines[1].length - lines[1].trimLeft().length;
      if (leadingSpaces > 0) {
        r = lines
            .map((line) => line.length < leadingSpaces
                ? line
                : line.substring(leadingSpaces))
            .toList();
      }
    }

    return r.join(newLineN).trim();
  }
}

extension ListJsonExt on JsonList {
  String get sjsonWithoutWrappers => sjson.sjsonWithoutWrappers;
}

extension MapJsonExt on JsonMap {
  String get sjsonWithoutWrappers => sjson.sjsonWithoutWrappers;
}
