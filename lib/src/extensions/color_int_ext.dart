import 'dart:typed_data';

const defaultColorInt = 0xFFFFFFFF;

extension ColorIntByteDataExtension on ByteData {
  int colorIntAt(int x, int y, int width) =>
      colorIntAtByteOffset((x + y * width) * 4);

  int colorIntAtByteOffset(int offset) => getUint32(offset).colorIntRgbaToArgb;
}

/// For represented Color like integer value.
/// Independent from material `Color`.
/// \see https://api.flutter.dev/flutter/material/Colors-class.html
///
/// The bits are interpreted as follows:
/// * Bits 24-31 are the alpha value.
/// * Bits 16-23 are the red value.
/// * Bits 8-15 are the green value.
/// * Bits 0-7 are the blue value.
///
/// \see `ColorExtension` from the project `flutter_helpers`.
extension ColorIntExt on int {
  /// Construct a color from the lower 8 bits of four integers.
  ///
  /// * `a` is the alpha value, with 0 being transparent and 255 being fully
  ///   opaque.
  /// * `r` is [colorIntRed], from 0 to 255.
  /// * `g` is [colorIntGreen], from 0 to 255.
  /// * `b` is [colorIntBlue], from 0 to 255.
  ///
  /// Out of range values are brought into range using modulo 255.
  int colorIntFromArgb(int a, int r, int g, int b) =>
      (((a & 0xff) << 24) |
          ((r & 0xff) << 16) |
          ((g & 0xff) << 8) |
          ((b & 0xff) << 0)) &
      0xFFFFFFFF;

  int get colorIntRgbaToArgb {
    final a = this & 0xFF;
    final rgb = this >> 8;
    return rgb + (a << 24);
  }

  String get colorIntToArgbString => toRadixString(16).padLeft(8, '0');

  /// The alpha channel of this color in an 8 bit value.
  ///
  /// A value of 0 means this color is fully transparent. A value of 255 means
  /// this color is fully opaque.
  int get colorIntAlpha => (0xff000000 & this) >> 24;

  /// The alpha channel of this color as a double.
  ///
  /// A value of 0.0 means this color is fully transparent. A value of 1.0 means
  /// this color is fully opaque.
  double get colorIntOpacity => colorIntAlpha / 0xFF;

  /// The red channel of this color in an 8 bit value.
  int get colorIntRed => (0x00ff0000 & this) >> 16;

  /// The green channel of this color in an 8 bit value.
  int get colorIntGreen => (0x0000ff00 & this) >> 8;

  /// The blue channel of this color in an 8 bit value.
  int get colorIntBlue => (0x000000ff & this) >> 0;

  /// Returns a new color that matches this color with the alpha channel
  /// replaced with `a` (which ranges from 0 to 255).
  ///
  /// Out of range values will have unexpected effects.
  int colorIntWithAlpha(int a) {
    return colorIntFromArgb(a, colorIntRed, colorIntGreen, colorIntBlue);
  }

  /// Returns a new color that matches this color with the alpha channel
  /// replaced with the given `opacity` (which ranges from 0.0 to 1.0).
  ///
  /// Out of range values will have unexpected effects.
  int colorIntWithOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return colorIntWithAlpha((255.0 * opacity).round());
  }

  bool get isGrayColorInt =>
      colorIntRed == colorIntGreen && colorIntGreen == colorIntBlue;
}

extension ColorIntStringExt on String {
  int get toColorInt {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    return hexColor.length == 8 ? int.parse('0x$hexColor') : defaultColorInt;
  }

  bool get isColor {
    var hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    return hexColor.length == 8;
  }
}
