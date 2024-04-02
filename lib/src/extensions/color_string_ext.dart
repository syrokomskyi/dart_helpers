import 'color_int_ext.dart';

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
