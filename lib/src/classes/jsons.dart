import 'dart:convert' as convert;

typedef JsonList = List<dynamic>;
typedef JsonMap = Map<String, dynamic>;

String jsonEncoder(dynamic o) =>
    const convert.JsonEncoder.withIndent('  ').convert(o);

dynamic jsonDecoder(String s) => convert.json.decode(s);
