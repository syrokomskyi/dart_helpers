import 'dart:typed_data';

import 'color_int_ext.dart';

extension ColorIntByteDataExtension on ByteData {
  /// ARGB
  int colorIntAt(
    int x,
    int y,
    int width, [
    int bytesPerColor = 4,
  ]) =>
      colorIntAtI(x + y * width, bytesPerColor);

  /// ARGB
  int colorIntAtI(int i, [int bytesPerColor = 4]) =>
      colorIntAtByteOffset(i * bytesPerColor);

  // ARGB
  void setColorInt(
    int x,
    int y,
    int width,
    int argb, [
    int bytesPerColor = 4,
  ]) =>
      setColorIntI(x + y * width, argb, bytesPerColor);

  // ARGB
  void setColorIntI(int i, int argb, [int bytesPerColor = 4]) =>
      setUint32(i * bytesPerColor, argb.colorIntArgbToRgba);

  /// ARGB
  int colorIntAtByteOffset(int offset, [int bytesPerColor = 4]) {
    final v = switch (bytesPerColor) {
      1 => getUint8(offset),
      2 => getUint16(offset),
      3 => getUint32(offset) & 0x00FFFFFF,
      4 => getUint32(offset),
      // ! A 64-bits unsupported for Javascript.
      // 5 => getUint64(offset) & 0x000000FFFFFFFFFF,
      // 6 => getUint64(offset) & 0x0000FFFFFFFFFFFF,
      // 7 => getUint64(offset) & 0x00FFFFFFFFFFFFFF,
      // 8 => getUint64(offset),
      _ => throw ArgumentError('Unsupported bytesPerColor: $bytesPerColor.'),
    };

    return v.colorIntRgbaToArgb;
  }
}
