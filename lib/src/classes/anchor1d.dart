/// See [Anchor1DExt].
class Anchor1D {
  const Anchor1D(this.x);

  static const start = Anchor1D(0.0);
  static const left = start;
  static const top = start;

  static const middle = Anchor1D(0.5);
  static const center = middle;

  static const right = end;
  static const bottom = end;
  static const end = Anchor1D(1.0);

  final double x;

  double toDouble() => x;
}
