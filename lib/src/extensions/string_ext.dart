extension StringExt on String {
  String get removedDoubleSpaces => replaceAll(RegExp(r'\s+'), ' ');

  String truncate([int len = 200, String omission = '…']) =>
      len >= length ? this : replaceRange(len, length, omission);

  String get toUpperCaseFirtsLetter =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}
