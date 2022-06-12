import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

extension OrientationExtension on Orientation {
  static const orientationList = <String, Orientation>{
    'landscape': Orientation.landscape,
    'portrait': Orientation.portrait,
  };

  bool get isPortrait => this == Orientation.portrait;

  bool get isLandscape => this == Orientation.landscape;

  String get sd =>
      orientationList.keys
          .firstWhereOrNull((key) => orientationList[key] == this) ??
      '';

  String get ss => sd == 'portrait' ? 'portrait' : 'landscape';
}

extension OrientationBuildStringExtension on String {
  Orientation? get buildDeviceOrientation =>
      OrientationExtension.orientationList[this];

  bool get isDeviceOrientation => buildDeviceOrientation != null;
}

extension DeviceOrientationExtension on DeviceOrientation {
  static const deviceOrientationList = <String, DeviceOrientation>{
    'landscape left': DeviceOrientation.landscapeLeft,
    'landscape right': DeviceOrientation.landscapeRight,
    'portrait up': DeviceOrientation.portraitUp,
    'portrait down': DeviceOrientation.portraitDown,
  };

  bool get isPortrait =>
      this == DeviceOrientation.portraitUp ||
      this == DeviceOrientation.portraitDown;

  bool get isLandscape =>
      this == DeviceOrientation.landscapeLeft ||
      this == DeviceOrientation.landscapeRight;

  String get sd =>
      deviceOrientationList.keys.firstWhereOrNull(
        (key) => deviceOrientationList[key] == this,
      ) ??
      '';

  String get ss => sd.startsWith('portrait') ? 'portrait' : 'landscape';
}

extension DeviceOrientationBuildStringExtension on String {
  DeviceOrientation? get buildDeviceOrientation {
    if (this == 'portrait') {
      return DeviceOrientation.portraitUp;
    }

    if (this == 'landscape') {
      return DeviceOrientation.landscapeLeft;
    }

    return DeviceOrientationExtension.deviceOrientationList[this];
  }

  bool get isDeviceOrientation => buildDeviceOrientation != null;
}
