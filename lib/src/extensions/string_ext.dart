extension StringExt on String {
  String get removedDoubleSpaces => replaceAll(RegExp(r'\s+'), ' ');

  String get removedDoubleChars {
    var r = '';
    for (var i = 0; i < length; ++i) {
      if (i == 0 || this[i] != this[i - 1]) {
        r += this[i];
      }
    }

    return r;
  }

  String get replaceNewLinesToRN =>
      replaceNewLinesRNtoN.replaceAll('\n', '\r\n');

  String get replaceNewLinesRNtoN => replaceAll('\r\n', '\n');

  /// For parse a MD-format text.
  String get replaceNewLinesToDoubleRN =>
      replaceNewLinesRNtoN.replaceAll('\n', '\r\n\r\n');

  String get replaceDoubleNewLinesToRN =>
      replaceNewLinesRNtoN.replaceAll('\n\n', '\r\n');

  @Deprecated('Use [abbreviate] instead. See https://strings.onepub.dev/parts')
  String truncate([int len = 200, String omission = '…']) =>
      len >= length ? this : replaceRange(len, length, omission);

  @Deprecated(
      'Use [toCapitalised] instead. See https://strings.onepub.dev/style')
  String get toUpperCaseFirtsLetter =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}
