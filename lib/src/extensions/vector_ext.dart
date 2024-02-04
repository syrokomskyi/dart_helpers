import 'package:vector_math/vector_math.dart';

import 'num_ext.dart';

extension Vector2Vector2Ext on Vector2 {
  static const zeroLength = 0.01;

  bool get isNearZero => length2 < zeroLength * zeroLength;

  bool isEqual(Vector2 b, [double epsilon = 0.01]) =>
      (x - b.x).abs() < epsilon && (y - b.y).abs() < epsilon;

  bool isEqualAsInt(Vector2 b) =>
      x.round() == b.x.round() && y.round() == b.y.round();

  double get aspectRatio => x / y;

  Vector2 get swapped => Vector2(y, x);

  String toDelimiterString([String delimiter = ' ', int fractionDigits = 0]) =>
      '${x.toStringAsFixed(fractionDigits)}'
      '$delimiter'
      '${y.toStringAsFixed(fractionDigits)}';

  List<double> toJson1() => toJson(digits: 1);

  List<double> toJson({int? digits}) =>
      (digits == null || digits < 1) ? [x, y] : [x.np(digits), y.np(digits)];

  String get s0 => '${x.toStringAsFixed(0)} ${y.toStringAsFixed(0)}';

  String get s1 => '${x.toStringAsFixed(1)} ${y.toStringAsFixed(1)}';

  String get s2 => '${x.toStringAsFixed(2)} ${y.toStringAsFixed(2)}';
}
