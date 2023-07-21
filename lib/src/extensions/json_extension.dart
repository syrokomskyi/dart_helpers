import 'package:vector_math/vector_math_64.dart';

import '../classes/jsons.dart';
import '../classes/size.dart';

extension SizeJsonExtension on Size {
  List<int> get json => [width.round(), height.round()];

  String get sjson => '[${width.round()}, ${height.round()}]';
}

extension Vector2JsonExtension on Vector2 {
  List<double> get json => [x, y];

  String get sjson => '[$x, $y]';
}

extension ObjectJsonExtension on Object {
  String get sjson => jsonEncoder(this);
}

extension StringJsonExtension on String {
  JsonList get jsonList => jsonDecoder(this) as JsonList;

  JsonMap get jsonMap => jsonDecoder(this) as JsonMap;
}
