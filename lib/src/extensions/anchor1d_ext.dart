import 'package:collection/collection.dart' show IterableExtension;

import '../classes/anchor1d.dart';

extension Anchor1DExt on Anchor1D {
  static final anchor1DList = <String, double>{
    'Left': Anchor1D.left.toDouble(),
    'left': Anchor1D.left.toDouble(),
    'Top': Anchor1D.top.toDouble(),
    'top': Anchor1D.top.toDouble(),
    'Center': Anchor1D.center.toDouble(),
    'center': Anchor1D.center.toDouble(),
    '': Anchor1D.center.toDouble(),
    'Right': Anchor1D.right.toDouble(),
    'right': Anchor1D.right.toDouble(),
    'Bottom': Anchor1D.bottom.toDouble(),
    'bottom': Anchor1D.bottom.toDouble(),
  };

  bool get byLeft => this == Anchor1D.left;

  bool get byTop => this == Anchor1D.top;

  bool get byCenter => this == Anchor1D.center;

  bool get byRight => this == Anchor1D.right;

  bool get byBottom => this == Anchor1D.bottom;

  String get s =>
      anchor1DList.keys.firstWhereOrNull(
        (key) => anchor1DList[key] == toDouble(),
      ) ??
      'center';
}

extension Anchor1DBuildStringExt on String {
  Anchor1D get buildAnchor1D => Anchor1D(Anchor1DExt.anchor1DList[this]!);

  bool get isAnchor1D => Anchor1DExt.anchor1DList.keys.contains(this);
}
