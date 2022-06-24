import 'dart:collection';

import 'package:vector_math/vector_math_64.dart';

import '../extensions/vector_extension.dart';

/// \see https://docs.flutter.dev/development/ui/assets-and-images#resolution-aware
/// \see https://en.wikipedia.org/wiki/Aspect_ratio_(image)
class PreferredAspect {
  final Vector2 size;

  /// Always use pairs as landscape AND portrait orientations.
  /// Most preferred go first.
  List<Vector2> get aspectSizeList => <Vector2>[
        Vector2(16, 9),
        Vector2(9, 16),
        Vector2(16, 7),
        Vector2(7, 16),
        Vector2(4, 3),
        Vector2(3, 4),
        Vector2(1, 1),
      ];

  const PreferredAspect(this.size);

  Vector2 preferredAspectSize() => preferredAspectSizes().values.first;

  SplayTreeMap<double, Vector2> preferredAspectSizes() {
    assert(!size.isNearZero);

    final map = SplayTreeMap<double, Vector2>();
    for (final aspectSize in aspectSizeList) {
      map[_deltaAspectRatio(size, aspectSize)] = aspectSize;
    }

    return map;
  }

  static double _deltaAspectRatio(Vector2 a, Vector2 b) =>
      (a.aspectRatio - b.aspectRatio).abs();
}
