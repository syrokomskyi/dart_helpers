/// See [Anchor1DExt].
class Anchor1D {
  const Anchor1D(this.x);

  static const left = Anchor1D(0.0);
  static const top = Anchor1D(0.0);
  static const center = Anchor1D(0.5);
  static const right = Anchor1D(1.0);
  static const bottom = Anchor1D(1.0);

  final double x;

  double toDouble() => x;
}
