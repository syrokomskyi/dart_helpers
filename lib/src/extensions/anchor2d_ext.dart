import 'package:collection/collection.dart' show IterableExtension;
import 'package:vector_math/vector_math_64.dart';

import '../classes/anchor2d.dart';

extension Anchor2DExt on Anchor2D {
  static final anchor2DList = <String, Vector2>{
    'topLeft': Anchor2D.topLeft.toVector2(),
    'top left': Anchor2D.topLeft.toVector2(),
    'leftTop': Anchor2D.topLeft.toVector2(),
    'left top': Anchor2D.topLeft.toVector2(),
    'topCenter': Anchor2D.topCenter.toVector2(),
    'top center': Anchor2D.topCenter.toVector2(),
    'centerTop': Anchor2D.topCenter.toVector2(),
    'center top': Anchor2D.topCenter.toVector2(),
    'topRight': Anchor2D.topRight.toVector2(),
    'top right': Anchor2D.topRight.toVector2(),
    'rightTop': Anchor2D.topRight.toVector2(),
    'right top': Anchor2D.topRight.toVector2(),
    'centerLeft': Anchor2D.centerLeft.toVector2(),
    'center left': Anchor2D.centerLeft.toVector2(),
    'leftCenter': Anchor2D.centerLeft.toVector2(),
    'left center': Anchor2D.centerLeft.toVector2(),
    '': Anchor2D.center.toVector2(),
    'center': Anchor2D.center.toVector2(),
    'center center': Anchor2D.center.toVector2(),
    'centerRight': Anchor2D.centerRight.toVector2(),
    'center right': Anchor2D.centerRight.toVector2(),
    'rightCenter': Anchor2D.centerRight.toVector2(),
    'right center': Anchor2D.centerRight.toVector2(),
    'bottomLeft': Anchor2D.bottomLeft.toVector2(),
    'bottom left': Anchor2D.bottomLeft.toVector2(),
    'leftBottom': Anchor2D.bottomLeft.toVector2(),
    'left bottom': Anchor2D.bottomLeft.toVector2(),
    'bottomCenter': Anchor2D.bottomCenter.toVector2(),
    'bottom center': Anchor2D.bottomCenter.toVector2(),
    'centerBottom': Anchor2D.bottomCenter.toVector2(),
    'center bottom': Anchor2D.bottomCenter.toVector2(),
    'bottomRight': Anchor2D.bottomRight.toVector2(),
    'bottom right': Anchor2D.bottomRight.toVector2(),
    'rightBottom': Anchor2D.bottomRight.toVector2(),
    'right bottom': Anchor2D.bottomRight.toVector2(),
  };

  bool get byLeft =>
      this == Anchor2D.topLeft ||
      this == Anchor2D.bottomLeft ||
      this == Anchor2D.centerLeft;

  bool get byTop =>
      this == Anchor2D.topLeft ||
      this == Anchor2D.topRight ||
      this == Anchor2D.topCenter;

  bool get byRight =>
      this == Anchor2D.topRight ||
      this == Anchor2D.bottomRight ||
      this == Anchor2D.centerRight;

  bool get byBottom =>
      this == Anchor2D.bottomLeft ||
      this == Anchor2D.bottomRight ||
      this == Anchor2D.bottomCenter;

  bool get byCenter =>
      this == Anchor2D.center ||
      this == Anchor2D.centerLeft ||
      this == Anchor2D.centerRight ||
      this == Anchor2D.topCenter ||
      this == Anchor2D.bottomCenter;

  String get s =>
      anchor2DList.keys.firstWhereOrNull(
        (key) => anchor2DList[key] == toVector2(),
      ) ??
      'center';
}

extension Anchor2DBuildStringExt on String {
  Anchor2D get buildAnchor2D => Anchor2D(
        Anchor2DExt.anchor2DList[this]!.x,
        Anchor2DExt.anchor2DList[this]!.y,
      );

  bool get isAnchor2D => Anchor2DExt.anchor2DList.keys.contains(this);
}
