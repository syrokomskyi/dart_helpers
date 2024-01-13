import 'dart:collection';

import '../../dart_helpers.dart';

/// \see https://docs.flutter.dev/development/ui/assets-and-images#resolution-aware
/// \see https://en.wikipedia.org/wiki/Aspect_ratio_(image)
class PreferredAspect {
  const PreferredAspect(this.size);

  static const aspectSizeDelimiter = 'to';

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

  Vector2 preferredAspectSize() => preferredAspectSizes().values.first;

  SplayTreeMap<double, Vector2> preferredAspectSizes() {
    assert(!size.isNearZero);

    final map = SplayTreeMap<double, Vector2>();
    for (final aspectSize in aspectSizeList) {
      map[_deltaAspectRatio(size, aspectSize)] = aspectSize;
    }

    return map;
  }

  /// First best available aspect size from prepared aspect sizes list.
  Vector2 bestAvailableAspectSize(List<Vector2> availableAspectSizes) {
    assert(!size.isNearZero);
    assert(availableAspectSizes.isNotEmpty);

    final aspectSizes = preferredAspectSizes().values;
    for (final aspectSize in aspectSizes) {
      if (availableAspectSizes.contains(aspectSize)) {
        return aspectSize;
      }
    }

    return availableAspectSizes.first;
  }

  /// In percents.
  int bestScale(Vector2 original, List<int> availableScales) {
    assert(!size.isNearZero);

    if (original.isNearZero || availableScales.isEmpty) {
      return 0;
    }

    var prevScale = availableScales.first;
    for (final scale in availableScales) {
      assert(scale > 0 && scale <= 100);
      assert(scale <= prevScale,
          'The available scales should be sorted in descending order.');
      final originalSize = original * scale.toDouble() / 100;
      if (originalSize.x < size.x || originalSize.y < size.y) {
        return prevScale;
      }
      prevScale = scale;
    }

    return prevScale;
  }

  Vector2? bestSize(List<Vector2> spriteSizes) {
    assert(!size.isNearZero);

    if (spriteSizes.isEmpty) {
      return null;
    }

    final ss = List<Vector2>.from(spriteSizes);
    ss.sort((a, b) => a.x.compareTo(b.x));

    Vector2? r;
    for (final spriteSize in ss) {
      if (spriteSize.x < size.x) {
        continue;
      }
      r = spriteSize;
      break;
    }

    if (r == null && ss.isNotEmpty) {
      r = ss.last;
    }

    return r;
  }

  /// \return 0 when `spriteSizes` doesn't contain `size`.
  int resolutionDividerForSize(List<Vector2> spriteSizes) {
    //assert(!size.isNearZero || isFlutterTestEnvironment);

    if (spriteSizes.isNotEmpty) {
      final ss = List<Vector2>.from(spriteSizes);
      ss.sort((a, b) => b.x.compareTo(a.x));

      var divider = 1;
      for (final spriteSize in ss) {
        if (size == spriteSize) {
          return divider;
        }
        divider *= 2;
      }
    }

    return 0;
  }

  static String preferredSuffix(Vector2 aspectSize) =>
      aspectSize.likeAspectSizeString;

  static double _deltaAspectRatio(Vector2 a, Vector2 b) =>
      (a.aspectRatio - b.aspectRatio).abs();
}

// \see size_extension.dart
// \todo Nice group for this and size_extension.dart.
extension PreferredAspectSizeOnSizeExtension on Vector2 {
  String get likeAspectSizeString =>
      '${x.round()}${PreferredAspect.aspectSizeDelimiter}${y.round()}';
}

extension PreferredAspectSizeOnStringExtension on String {
  /// Works only with string represented from
  /// [PreferredAspectSizeOnSizeExtension.likeAspectSizeString].
  Vector2 get likeAspectSize {
    final s = trim();
    if (s.isEmpty) {
      return Vector2.zero();
    }

    final l = s.split(PreferredAspect.aspectSizeDelimiter);
    assert(
        l.length == 2,
        'String should be contains the numeric values separated the'
        ' PreferredAspect.aspectSizeDelimiter = '
        ' `${PreferredAspect.aspectSizeDelimiter}`.'
        ' Has: `$l`');

    if (l.length != 2) {
      return Vector2.zero();
    }

    final sx = l[0];
    final x = int.tryParse(sx);
    assert(x != null, "Can't parse X from `$sx`");

    final sy = l[1];
    final y = int.tryParse(sy);
    assert(y != null, "Can't parse Y from `$sy`");

    return Vector2(x?.toDouble() ?? 0, y?.toDouble() ?? 0);
  }
}
