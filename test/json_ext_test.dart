import 'package:dart_helpers/dart_helpers.dart';
import 'package:test/test.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  test('blured', () {
    expect({'api_key': '12345-ab'}.blured(), {'api_key': '********'});
    expect({'password': '12345-ab'}.blured(), {'password': '********'});
    expect({'passw': '12345-ab'}.blured(), {'passw': '********'});
    expect({'psw': '12345-ab'}.blured(), {'psw': '********'});
    expect({'pswd': '12345-ab'}.blured(), {'pswd': '********'});
    expect({'my_passw': '12345-ab'}.blured(), {'my_passw': '********'});
    expect({'my_secret': '12345-ab'}.blured(), {'my_secret': '********'});
    expect({'my_secret': ' 12345-ab  '}.blured(), {'my_secret': '***********'});

    expect({'my_field': 'abc  '}.blured(), {'my_field': 'abc  '});
  });

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

  test('sjson encodable object', () {
    expect(const Size(11, 12).sjson, '[\n  11,\n  12\n]');
    expect(Vector2(1.0, -0.2).sjson, '[\n  1.0,\n  -0.2\n]');
  });

  test('sjsonInLine encodable object', () {
    expect(const Size(11, 12).sjsonInLine, '[11,12]');
    expect(Vector2(1.0, -0.2).sjsonInLine, '[1.0,-0.2]');
  });

  test('sjsonInLineWithoutWrappers encodable object', () {
    expect(const Size(11, 12).sjsonInLineWithoutWrappers, '11,12');
    expect(Vector2(1.0, -0.2).sjsonInLineWithoutWrappers, '1.0,-0.2');
  });

  test('sjson non-encodable object', () {
    expect(
      const NonEncodableObject().sjson,
      '"Instance of \'NonEncodableObject\'"',
    );
  });

  test('sjson array with null object', () {
    expect([null, 12].sjson, '[\n  null,\n  12\n]');
  });

  test('sjsonInLine array with null object', () {
    expect([null, 12].sjsonInLine, '[null,12]');
  });

  test('sjsonInLineWithoutWrappers array with null object', () {
    expect([null, 12].sjsonInLineWithoutWrappers, 'null,12');
  });

  test('sjsonWithoutWrappers array with non-encodable objects', () {
    expect(
      [const NonEncodableObject()].sjsonWithoutWrappers,
      '"Instance of \'NonEncodableObject\'"',
    );
  });

  test('sjsonInLineWithoutWrappers array with non-encodable object', () {
    expect(
      [const NonEncodableObject()].sjsonInLineWithoutWrappers,
      '"Instance of \'NonEncodableObject\'"',
    );
  });

  test('sjsonWithoutWrappers array', () {
    expect([10, 11, 12].sjsonWithoutWrappers, '10,\n11,\n12');
  });

  test('sjsonInLineWithoutWrappers array', () {
    expect([10, 11, 12].sjsonInLineWithoutWrappers, '10,11,12');
  });

  test('sjsonWithoutWrappers array with null object', () {
    expect(
      [null, 12].sjsonWithoutWrappers,
      'null,\n12',
    );
  });

  test('sjsonInLineWithoutWrappers array with null object', () {
    expect(
      [null, 12].sjsonInLineWithoutWrappers,
      'null,12',
    );
  });

  test('sjsonWithoutWrappers object', () {
    expect({'t': 1}.sjsonWithoutWrappers, '"t": 1');
    expect({'a': 1, 'b': 2}.sjsonWithoutWrappers, '"a": 1,\n"b": 2');
    expect(
        {
          'o': {'u': 1}
        }.sjsonWithoutWrappers,
        '"o": {\n  "u": 1\n}');
  });

  test('sjsonInLineWithoutWrappers object', () {
    expect({'t': 1}.sjsonInLineWithoutWrappers, '"t":1');
    expect({'a': 1, 'b': 2}.sjsonInLineWithoutWrappers, '"a":1,"b":2');
    expect(
        {
          'o': {'u': 1}
        }.sjsonInLineWithoutWrappers,
        '"o":{"u":1}');
  });

  test('sjsonWithoutWrappers string', () {
    expect('"abc def"'.sjsonWithoutWrappers, 'abc def');
    expect('"abc\ndef"'.sjsonWithoutWrappers, 'abc\ndef');

    expect('""'.sjsonWithoutWrappers, '');
    expect('"    "'.sjsonWithoutWrappers, '');
    expect('"\n\n"'.sjsonWithoutWrappers, '');
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

class NonEncodableObject {
  const NonEncodableObject();
}
