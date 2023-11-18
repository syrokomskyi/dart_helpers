import 'dart:io' show Platform;

/// A host for connect from Dart/Flatter App from emulator
/// or local client to local server.
String get localHost => Platform.isAndroid ? '10.0.2.2' : 'localhost';
