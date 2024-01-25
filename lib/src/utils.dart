import 'dart:io' as io show Platform, sleep;
import 'dart:math';

import 'package:strings/strings.dart';
import 'package:vector_math/vector_math_64.dart';

import 'classes/jsons.dart';

/// Returns a `value` which normalized to range [a, b].
/// \see scaleToRangeVector2()
double scaleToRange(
  num value,
  num minValue,
  num maxValue,
  num a,
  num b,
) {
  final v = value.clamp(minValue, maxValue);
  return (b - a) * (v - minValue) / (maxValue - minValue) + a;
}

/// Same scaleToRange() by Vector2 values.
Vector2 scaleToRangeVector2(
  Vector2 value,
  Vector2 minValue,
  Vector2 maxValue,
  Vector2 a,
  Vector2 b,
) {
  return Vector2(scaleToRange(value.x, minValue.x, maxValue.x, a.x, b.x),
      scaleToRange(value.y, minValue.y, maxValue.y, a.y, b.y));
}

Vector2 fitSize(Vector2 ourSize, Vector2 wantSize) {
  final rs = wantSize.x / wantSize.y;
  final ri = ourSize.x / ourSize.y;
  return rs > ri
      ? Vector2(ourSize.x * wantSize.y / ourSize.y, wantSize.y)
      : Vector2(wantSize.x, ourSize.y * wantSize.x / ourSize.x);
}

double scaleFitSize(Vector2 ourSize, Vector2 wantSize) {
  final size = fitSize(ourSize, wantSize);
  return size.x / ourSize.x;
}

double scaleCoverSize(Vector2 ourSize, Vector2 wantSize) {
  final scaleWidth = wantSize.x > 0 ? wantSize.x / ourSize.x : 1.0;
  final scaleHeight = wantSize.y > 0 ? wantSize.y / ourSize.y : 1.0;
  return max(scaleWidth, scaleHeight);
}

bool isScaleCoverByHeight(Vector2 ourSize, Vector2 wantSize) {
  final scaleWidth = wantSize.x > 0 ? wantSize.x / ourSize.x : 1.0;
  final scaleHeight = wantSize.y > 0 ? wantSize.y / ourSize.y : 1.0;
  return scaleWidth < scaleHeight;
}

bool isScaleCoverByWidth(Vector2 ourSize, Vector2 wantSize) =>
    !isScaleCoverByHeight(ourSize, wantSize);

Vector2 correctTooBigSize(Vector2 ourSize, Vector2 wantSize) {
  final kx = ourSize.x / wantSize.x;
  final ky = ourSize.y / wantSize.y;
  final k = max(kx, ky);

  return k > 1 ? ourSize / k : ourSize;
}

/// Any string / key which starts on this symbol will ignore.
/// Ex. Can exclude cards without remove them from json / store.
/// \see [needIgnoreJsonKey]
bool needIgnore(String s, [String prefix = '-']) => s.startsWith(prefix);

/// \see [needIgnore]
bool needIgnoreJsonKey(JsonMap json, String key) =>
    needIgnore((json[key] ?? '') as String);

Vector2 correctTooSmallSize(Vector2 ourSize, Vector2 wantSize) {
  // \todo Calculate by real visible size.
  // \todo Move all constant to the class Configure.
  const minSpriteSize = 12.0;
  var kx = 1.0;
  if (ourSize.x < minSpriteSize) {
    kx = ourSize.x / minSpriteSize;
  }
  var ky = 1.0;
  if (ourSize.y < minSpriteSize) {
    ky = ourSize.y / minSpriteSize;
  }
  final k = min(kx, ky);

  return k < 1 ? ourSize / k : ourSize;
}

String get operatingSystemOneLetter {
  const map = <String, String>{
    'android': 'a',
    'fuchsia': 'f',
    'ios': 'i',
    'linux': 'l',
    'macos': 'm',
    'windows': 'w',
  };

  return map[io.Platform.operatingSystem] ?? '';
}

String get operatingSystem {
  if (io.Platform.isIOS) {
    return 'iOS';
  }

  if (io.Platform.isMacOS) {
    return 'MacOS';
  }

  final os = io.Platform.operatingSystem;

  return os.toCapitalised();
}

Future<void> pause([
  Duration duration = const Duration(milliseconds: 2000),
]) async =>
    Future.delayed(duration);

Future<void> pauseInSecond() async => pauseInSeconds(1);

Future<void> pauseInSeconds([int seconds = 2]) async =>
    pauseInMilliseconds(seconds * 1000);

Future<void> pauseInMillisecond() async => pauseInMilliseconds(1);

Future<void> pauseInMilliseconds([int milliseconds = 2]) async =>
    pause(Duration(milliseconds: milliseconds));

void sleep([
  Duration duration = const Duration(milliseconds: 2000),
]) =>
    io.sleep(duration);

int get randomInt => Random().nextInt((1 << 32) ~/ 2) - (1 << 32) ~/ 2;

int get randomPositiveInt => Random().nextInt(1 << 32);
