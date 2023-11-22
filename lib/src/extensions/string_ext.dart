extension StringExt on String {
  /// Left [begin] first and [end] last symbols.
  /// Before them will insert [replacer].
  String bittenOf(int begin, int end, [String replacer = '..']) {
    if (isEmpty) {
      return this;
    }

    final pbegin = begin.clamp(0, length);
    final pend = end.clamp(0, length);

    if (pbegin == 0 && pend == 0) {
      return '';
    }

    if (pbegin + pend >= length) {
      return this;
    }

    final a = substring(0, pbegin);
    final b = substring(length - pend);

    return '$a$replacer$b';
  }

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

extension ListStringExt on List<String> {
  /// Same [bittenOf] but for the each string into the list.
  List<String> bittenOf(int begin, int end, [String replacer = '..']) =>
      map((e) => e.bittenOf(begin, end, replacer)).toList();
}

extension SetStringExt on Set<String> {
  /// Same [bittenOf] but for the each string into the set.
  Set<String> bittenOf(int begin, int end, [String replacer = '..']) =>
      map((e) => e.bittenOf(begin, end, replacer)).toSet();
}
