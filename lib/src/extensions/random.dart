import 'dart:math';

extension RandomListItem<T> on List<T> {
  /// Random item from the [List].
  T randomItem() {
    if (isEmpty) {
      throw ArgumentError('The empty list.');
    }

    return this[Random().nextInt(length)];
  }

  /// Returns [n] random unique entries (elements of [List]).
  List<T> randomItems(int n) {
    if (isEmpty) {
      throw ArgumentError('The empty list.');
    }

    if (n < 1) {
      throw ArgumentError('The `n` should be 1 or greater.');
    }

    final l = List<T>.from(this)..shuffle();

    return l.sublist(0, n < length ? n : length);
  }
}

extension RandomMapItem<K, V> on Map<K, V> {
  /// Random entry from the [Map].
  MapEntry<K, V> randomEntry() {
    if (isEmpty) {
      throw ArgumentError('The empty list.');
    }

    return entries.toList()[Random().nextInt(length)];
  }

  /// Returns [n] random unique entries (elements of [Map]).
  List<MapEntry<K, V>> randomEntries(int n) {
    if (isEmpty) {
      throw ArgumentError('The empty map.');
    }

    if (n < 1) {
      throw ArgumentError('The `n` should be 1 or greater.');
    }

    final l = List<MapEntry<K, V>>.from(entries)..shuffle();

    return l.sublist(0, n < length ? n : length);
  }
}
