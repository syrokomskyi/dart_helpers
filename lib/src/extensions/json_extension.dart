import 'dart:convert' as convert;
import 'dart:ui';

import 'package:vector_math/vector_math_64.dart';

const _encoder = convert.JsonEncoder.withIndent('  ');

String jsonEncoder(dynamic o) => _encoder.convert(o);

extension SizeJsonExtension on Size {
  List<int> get json => [width.round(), height.round()];

  String get sjson => '[${width.round()}, ${height.round()}]';
}

extension Vector2JsonExtension on Vector2 {
  List<double> get json => [x, y];

  String get sjson => '[$x, $y]';
}

extension ObjectJsonExtension on Object {
  String get sjson => _encoder.convert(this);
}

extension StringJsonExtension on String {
  List<dynamic> get jsonList => convert.json.decode(this) as List<dynamic>;

  Map<String, dynamic> get jsonMap =>
      convert.json.decode(this) as Map<String, dynamic>;
}
