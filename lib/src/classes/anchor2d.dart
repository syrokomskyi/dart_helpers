import 'package:vector_math/vector_math_64.dart';

/// See [Anchor2DExt].
class Anchor2D {
  const Anchor2D(this.x, this.y);

  static const topLeft = Anchor2D(0.0, 0.0);
  static const topCenter = Anchor2D(0.5, 0.0);
  static const topRight = Anchor2D(1.0, 0.0);
  static const centerLeft = Anchor2D(0.0, 0.5);
  static const center = Anchor2D(0.5, 0.5);
  static const centerRight = Anchor2D(1.0, 0.5);
  static const bottomLeft = Anchor2D(0.0, 1.0);
  static const bottomCenter = Anchor2D(0.5, 1.0);
  static const bottomRight = Anchor2D(1.0, 1.0);

  final double x;
  final double y;

  Vector2 toVector2() => Vector2(x, y);
}
