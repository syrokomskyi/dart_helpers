import 'package:collection/collection.dart';

extension EnumExt on List<Enum> {
  /// Example:
  /// ```
  /// UnitType.values.findByName(s, defaults: UnitType.m);
  /// ```
  T? findByName<T>(
    String name, {
    T? defaults,
  }) =>
      (firstWhereOrNull((e) => e.name == name) ?? defaults) as T?;
}
