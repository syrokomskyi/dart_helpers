import 'dart:math';

extension RandomIterableItemExt<T> on Iterable<T> {
  /// Random item from the [Iterable].
  T randomItem() => toList().randomItem();
}

extension RandomListItemExt<T> on List<T> {
  /// Random item from the [List].
  T randomItem() {
    if (isEmpty) {
      throw ArgumentError('The empty list.');
    }

    return this[_random.nextInt(length)];
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

extension RandomMapItemExt<K, V> on Map<K, V> {
  /// Random entry from the [Map].
  MapEntry<K, V> randomEntry() {
    if (isEmpty) {
      throw ArgumentError('The empty list.');
    }

    return entries.toList()[_random.nextInt(length)];
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

/// [-(1 << 32) ~/ 2; (1 << 32) ~/ 2)
int get randomInt => _random.nextInt((1 << 32) ~/ 2) - (1 << 32) ~/ 2;

/// [0; 1 << 32)
int get randomPositiveInt => _random.nextInt(1 << 32);

/// [min; max)
int randomIntRange(int min, int max) => min + _random.nextInt(max - min + 1);

/// [min; max)
double randomDoubleRange(double min, double max) =>
    min + _random.nextDouble() * (max - min);

final _random = Random();
