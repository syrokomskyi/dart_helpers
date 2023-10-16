import 'package:json_annotation/json_annotation.dart';
import 'package:vector_math/vector_math_64.dart';

class Vector2JsonNullConverter implements JsonConverter<Vector2?, List<num>?> {
  const Vector2JsonNullConverter();

  @override
  Vector2? fromJson(List<num>? l) => l != null && l.length == 2
      ? Vector2(l[0].toDouble(), l[1].toDouble())
      : null;

  @override
  List<double> toJson(Vector2? o) => o == null ? [] : [o.x, o.y];
}

class Vector2JsonConverter implements JsonConverter<Vector2, List<num>> {
  const Vector2JsonConverter();

  @override
  Vector2 fromJson(List<num> l) => l.length == 2
      ? Vector2(l[0].toDouble(), l[1].toDouble())
      : Vector2.zero();

  @override
  List<double> toJson(Vector2 o) => [o.x, o.y];
}

class Vector2IntJsonNullConverter
    implements JsonConverter<Vector2?, List<num>?> {
  const Vector2IntJsonNullConverter();

  @override
  Vector2? fromJson(List<num>? l) => l != null && l.length == 2
      ? Vector2(l[0].roundToDouble(), l[1].roundToDouble())
      : null;

  @override
  List<double> toJson(Vector2? o) =>
      o == null ? [] : [o.x.roundToDouble(), o.y.roundToDouble()];
}

class Vector2IntJsonConverter implements JsonConverter<Vector2, List<num>> {
  const Vector2IntJsonConverter();

  @override
  Vector2 fromJson(List<num> l) => l.length == 2
      ? Vector2(l[0].roundToDouble(), l[1].roundToDouble())
      : Vector2.zero();

  @override
  List<double> toJson(Vector2 o) => [o.x.roundToDouble(), o.y.roundToDouble()];
}
