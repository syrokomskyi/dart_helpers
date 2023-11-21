import 'package:dart_helpers/dart_helpers.dart';
import 'package:test/test.dart';

void main() {
  test('jsonWithSignificantFields', () {
    const json = <String, dynamic>{
      // null
      'null': null,
      // bool
      'false_bool': false,
      'true_bool': true,
      // int
      'zero_int': 0,
      'positive_int': 12,
      'negative_int': -12,
      // double
      'positive_zero_double': 0.0,
      'negative_zero_double': -0.0,
      'positive_double': 1.2,
      'negative_double': -1.2,
      'positive_infinity_double': double.infinity,
      'negative_infinity_double': double.negativeInfinity,
      'nan_double': double.nan,
      // string
      'empty_string': '',
      'spaced_string': '    ',
      'filled_string': 'a bcd efghijkl',
      // enum
      'first_enum': TestEnum.unspecified,
      'second_enum': TestEnum.a,
      // list
      'empty_list': <int>[],
      'one_empty_element_list': <int>[0],
      'two_empty_elements_list': <int>[0, 0],
      'list': <int>[1, 2],
      // map
      'empty_map': <String, dynamic>{},
      'one_empty_element_map': <String, dynamic>{'': 0},
      'one_not_empty_value_element_map': <String, dynamic>{'': 12},
      'one_not_empty_key_element_map': <String, dynamic>{'a': 0},
      'two_empty_values_elements_map': <String, dynamic>{'a': 0, 'b': 0},
      'map': <String, dynamic>{'a': 1, 'b': 2},
      // set
      'empty_set': <int>{},
      'one_empty_element_set': <int>{0},
      'set': <int>{1, 2},
    };

    expect(
        json.jsonWithSignificantFields.keys,
        {
          // bool
          'true_bool': true,
          // int
          'positive_int': 12,
          'negative_int': -12,
          // double
          'positive_double': 1.2,
          'negative_double': -1.2,
          'positive_infinity_double': double.infinity,
          'negative_infinity_double': double.negativeInfinity,
          'nan_double': double.nan,
          // string
          'spaced_string': '    ',
          'filled_string': 'a bcd efghijkl',
          // enum
          'second_enum': TestEnum.a,
          // list
          'one_empty_element_list': <int>[0],
          'two_empty_elements_list': <int>[0, 0],
          'list': <int>[1, 2],
          // map
          'one_not_empty_value_element_map': <String, dynamic>{'': 12},
          'map': <String, dynamic>{'a': 1, 'b': 2},
          // set
          'one_empty_element_set': <int>{0},
          'set': <int>{1, 2},
        }.keys);
  });

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

enum TestEnum { unspecified, a, b }
