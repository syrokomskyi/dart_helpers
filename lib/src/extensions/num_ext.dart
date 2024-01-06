import 'dart:math';

/// For advance calculation we can use
/// <https://github.com/gameticharles/advance_math/blob/main/lib/src/math/basic/basic.dart>
extension DoubleExt on double {
  static const defaultZeroValue = 0.01;

  bool get isNearZero => isNear(0.0);

  bool get isNearOne => isNear(1.0);

  bool isNear(double v, [double zeroValue = defaultZeroValue]) =>
      (this - v).abs() < zeroValue;

  double get n0 => np(0);

  double get n1 => np(1);

  double get n2 => np(2);

  double get n3 => np(3);

  double get n4 => np(4);

  double np(int decimalPlaces) {
    if (decimalPlaces == 0) {
      return roundToDouble();
    }

    final p = pow(10, decimalPlaces);

    return (this * p).roundToDouble() / p;
  }

  String get s0 => toStringAsFixed(0);

  String get s1 => toStringAsFixed(1);

  String get s2 => toStringAsFixed(2);

  String get s3 => toStringAsFixed(3);

  String get s4 => toStringAsFixed(4);
}
