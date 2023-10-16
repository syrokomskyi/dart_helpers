/// Prefer use a `Vector2` and `vector_extension.dart` instead this `Size`.
class Size {
  const Size(this.width, this.height)
      : assert(width >= 0),
        assert(height >= 0);

  final num width;
  final num height;

  static Size get one => const Size(1, 1);

  static Size get zero => const Size(0, 0);

  bool get isEmpty => width == 0 && height == 0;

  double get aspectRatio => width / height;

  Size operator +(Size other) =>
      Size(width + other.width, height + other.height);

  Size operator -(Size other) =>
      Size(width - other.width, height - other.height);

  Size operator *(num factor) => Size(width * factor, height * factor);

  Size operator /(num factor) => Size(width / factor, height / factor);

  Size round() => Size(width.roundToDouble(), height.roundToDouble());

  Size ceil() => Size(width.ceilToDouble(), height.ceilToDouble());

  Size floor() => Size(width.floorToDouble(), height.floorToDouble());

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => (width + 3571 * height).toInt();

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      other is Size && width == other.width && height == other.height;

  @override
  String toString() => '[$width, $height]';

  String toDelimiterString(String delimiter) => '$width$delimiter$height';
}
