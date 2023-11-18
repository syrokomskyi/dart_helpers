import 'package:dart_helpers/dart_helpers.dart';
import 'package:test/test.dart';

void main() {
  test('sjsonWithoutWrappers array', () {
    expect([10, 11, 12].sjsonWithoutWrappers, '10,\r\n11,\r\n12');
  });

  test('sjsonWithoutWrappers object', () {
    expect({'t': 1}.sjsonWithoutWrappers, '"t": 1');
    expect({'a': 1, 'b': 2}.sjsonWithoutWrappers, '"a": 1,\r\n"b": 2');
    expect(
        {
          'o': {'u': 1}
        }.sjsonWithoutWrappers,
        '"o": {\r\n  "u": 1\r\n}');
  });
}
