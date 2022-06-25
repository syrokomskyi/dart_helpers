import 'dart:async' show Completer;
import 'dart:io' as io show Directory, File, FileSystemEntity, Platform, sleep;
import 'dart:math';

import 'package:vector_math/vector_math_64.dart';

import 'extensions/color_int_extension.dart';

Future<List<io.FileSystemEntity>> allFilesFromDirectory(
  io.Directory dir, [
  bool recursive = false,
]) {
  final r = <io.File>[];

  final completer = Completer<List<io.FileSystemEntity>>();
  final lister = dir.list(recursive: recursive);
  lister.listen(
    (file) {
      if (file is io.File) {
        r.add(file);
      }
    },
    onDone: () => completer.complete(r),
    onError: print,
  );

  return completer.future;
}

/// Returns a `value` which normalized to range [a, b].
/// \see scaleToRangeVector2()
double scaleToRange(
  double value,
  double minValue,
  double maxValue,
  double a,
  double b,
) {
  final num v = value.clamp(minValue, maxValue);
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

Vector2 fitSize(Vector2 ownSize, Vector2 screenSize) {
  final rs = screenSize.x / screenSize.y;
  final ri = ownSize.x / ownSize.y;
  return rs > ri
      ? Vector2(ownSize.x * screenSize.y / ownSize.y, screenSize.y)
      : Vector2(screenSize.x, ownSize.y * screenSize.x / ownSize.x);
}

double scaleFitSize(Vector2 ownSize, Vector2 screenSize) {
  final size = fitSize(ownSize, screenSize);
  return size.x / ownSize.x;
}

double scaleCoverSize(Vector2 ownSize, Vector2 screenSize) {
  final scaleWidth = screenSize.x > 0 ? screenSize.x / ownSize.x : 1.0;
  final scaleHeight = screenSize.y > 0 ? screenSize.y / ownSize.y : 1.0;
  return max(scaleWidth, scaleHeight);
}

bool isScaleCoverByHeight(Vector2 someSize, Vector2 screenSize) {
  final scaleWidth = screenSize.x > 0 ? screenSize.x / someSize.x : 1.0;
  final scaleHeight = screenSize.y > 0 ? screenSize.y / someSize.y : 1.0;
  return scaleWidth < scaleHeight;
}

bool isScaleCoverByWidth(Vector2 ownSize, Vector2 screenSize) =>
    !isScaleCoverByHeight(ownSize, screenSize);

Vector2 correctTooBigSize(Vector2 ownSize, Vector2 screenSize) {
  final kx = ownSize.x / screenSize.x;
  final ky = ownSize.y / screenSize.y;
  final k = max(kx, ky);

  return k > 1 ? ownSize / k : ownSize;
}

/// Any string / key which starts on this symbol will ignore.
/// Ex. Can exclude cards without remove them from json / store.
/// \see [needIgnoreJsonKey]
bool needIgnore(String s, [String prefix = '-']) => s.startsWith(prefix);

/// \see [needIgnore]
bool needIgnoreJsonKey(Map<String, dynamic> json, String key) =>
    needIgnore((json[key] ?? '') as String);

Vector2 correctTooSmallSize(Vector2 ownSize, Vector2 screenSize) {
  // \todo Calculate by real visible size.
  // \todo Move all constant to the class Configure.
  const minSpriteSize = 12.0;
  var kx = 1.0;
  if (ownSize.x < minSpriteSize) {
    kx = ownSize.x / minSpriteSize;
  }
  var ky = 1.0;
  if (ownSize.y < minSpriteSize) {
    ky = ownSize.y / minSpriteSize;
  }
  final k = min(kx, ky);

  return k < 1 ? ownSize / k : ownSize;
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

  return os.isNotEmpty ? '${os[0].toUpperCase()}${os.substring(1)}' : '';
}

Future<void> pause([
  Duration duration = const Duration(milliseconds: 1000),
]) async =>
    Future.delayed(duration);

void sleep([
  Duration duration = const Duration(milliseconds: 1000),
]) =>
    io.sleep(duration);

int get randomInt => Random().nextInt((1 << 32) ~/ 2) - (1 << 32) ~/ 2;

int get randomPositiveInt => Random().nextInt(1 << 32);

bool get isTestEnvironment =>
    io.Platform.environment.containsKey('FLUTTER_TEST');

bool isGrayColorInt(int color, int x, int y) =>
    color.colorIntRed == color.colorIntGreen &&
    color.colorIntGreen == color.colorIntBlue;
