extension StringExtension on String {
  String truncate([int len = 200, String omission = '…']) =>
      len >= length ? this : replaceRange(len, length, omission);

  String get toUpperCaseFirtsLetter =>
      isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
}
