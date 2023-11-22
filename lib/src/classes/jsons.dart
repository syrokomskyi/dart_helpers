import 'dart:convert' as convert;

typedef JsonList = List<dynamic>;
typedef JsonMap = Map<String, dynamic>;

String jsonEncoder(
  dynamic o, {
  String indent = '  ',
  Object? Function(dynamic object)? toEncodable,
}) =>
    convert.JsonEncoder.withIndent(
      indent.isEmpty ? null : indent,
      toEncodable ?? (o) => '$o',
    ).convert(o);

dynamic jsonDecoder(String s) => convert.json.decode(s);
