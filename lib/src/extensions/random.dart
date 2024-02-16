import 'dart:math';

extension RandomListItem<T> on List<T> {
  /// Random item from the [List].
  T get randomItem => this[Random().nextInt(length)];
}

extension RandomMapItem<K, V> on Map<K, V> {
  /// Random entry from the [Map].
  MapEntry<K, V> get randomEntry => entries.toList()[Random().nextInt(length)];
}
