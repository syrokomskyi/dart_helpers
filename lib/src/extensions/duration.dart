/// Extensions to make creating [Duration] simple.
/// ```
/// 200.ms    == Duration(milliseconds: 200)
/// 3.seconds == Duration(milliseconds: 3000)
/// 1.5.days  == Duration(hours: 36)
/// ```
/// Thanks <https://pub.dev/packages/flutter_animate>.
extension NumDurationExt on num {
  Duration get microseconds => Duration(microseconds: round());

  /// Alias [milliseconds].
  Duration get ms => milliseconds;
  Duration get milliseconds => (this * 1000).microseconds;

  Duration get seconds => (this * 1000 * 1000).microseconds;

  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;

  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;

  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;

  Duration get weeks => (this * 1000 * 1000 * 60 * 60 * 24 * 7).microseconds;

  /// 1 month == 30 days
  Duration get months => (this * 1000 * 1000 * 60 * 60 * 24 * 30).microseconds;

  /// 1 year == 365 days
  Duration get years => (this * 1000 * 1000 * 60 * 60 * 24 * 365).microseconds;
}
