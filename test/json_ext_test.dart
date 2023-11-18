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

  test('sjsonWithoutWrappers string', () {
    expect('"abc def"'.sjsonWithoutWrappers, 'abc def');
    expect('"abc\r\ndef"'.sjsonWithoutWrappers, 'abc\r\ndef');

    expect('""'.sjsonWithoutWrappers, '');
    expect('"    "'.sjsonWithoutWrappers, '');
    expect('"\r\n\r\n"'.sjsonWithoutWrappers, '');
  });

  test('sjsonWithoutWrappers bool', () {
    expect('true'.sjsonWithoutWrappers, 'true');
    expect('false'.sjsonWithoutWrappers, 'false');
  });

  test('sjsonWithoutWrappers num', () {
    expect('12345'.sjsonWithoutWrappers, '12345');
    expect('1234.5'.sjsonWithoutWrappers, '1234.5');
  });

  test('sjsonWithoutWrappers null', () {
    expect('null'.sjsonWithoutWrappers, 'null');
  });
}
