// ignore_for_file: avoid_print

import 'package:dart_helpers/src/extensions/random.dart';
import 'package:test/test.dart';

void main() {
  group('RandomListItem.randomItem', () {
    test('empty list', () {
      const list = <int>[];
      expect(() => list.randomItem(), throwsA(isA<ArgumentError>()));
    });

    test('1 element list', () {
      const list = <int>[12];
      expect(list.randomItem(), list.first);
    });

    test('2 elements list', () {
      const list = <int>[12, 13];
      final r = list.randomItem();
      expect(list.contains(r), isTrue, reason: '$r');
    });
  });

  group('RandomListItem.randomItems', () {
    test('empty list', () {
      const list = <int>[];
      expect(() => list.randomItems(1), throwsA(isA<ArgumentError>()));
    });

    test('1 element list', () {
      const list = <int>[12];
      expect(() => list.randomItems(0), throwsA(isA<ArgumentError>()));
      expect(list.randomItems(1), list);
      expect(list.randomItems(2), list);
      expect(list.randomItems(100), list);
    });

    test('6 elements list', () {
      const list = <int>[12, 13, 14, 30, 20, 10];
      expect(() => list.randomItems(0), throwsA(isA<ArgumentError>()));
      expect(() => list.randomItems(-1), throwsA(isA<ArgumentError>()));
      {
        final r = list.randomItems(1);
        expect(r.length, 1, reason: '$r');
        expect(list, containsAll(r), reason: '$r');
      }
      {
        final r = list.randomItems(3);
        expect(r.length, 3, reason: '$r');
        expect(list, containsAll(r), reason: '$r');
      }
      {
        final r = list.randomItems(6);
        expect(r.length, list.length, reason: '$r');
        expect(list, containsAll(r), reason: '$r');
      }
      {
        final r = list.randomItems(600);
        expect(r.length, list.length, reason: '$r');
        expect(list, containsAll(r), reason: '$r');
      }
    });
  });
}
