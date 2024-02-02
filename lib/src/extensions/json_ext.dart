import 'package:json_dart/json_dart.dart';

import '../classes/size.dart';
import 'string_ext.dart';

extension JsonCleanProto3Ext on JsonMap {
  /// Same [bittenOf] but for the each string into the map (json).
  Map<String, dynamic> bittenOf(int begin, int end, [String replacer = '..']) =>
      map((k, v) {
        late final dynamic r;
        if (v is String) {
          r = v.bittenOf(begin, end, replacer);
        } else if (v is Map<String, dynamic>) {
          r = v.bittenOf(begin, end, replacer);
        } else if (v is List<String>) {
          r = v.bittenOf(begin, end, replacer);
        } else if (v is Set<String>) {
          r = v.bittenOf(begin, end, replacer);
        } else {
          r = v;
        }

        return MapEntry(k, r);
      });
}

/// See [ObjectJsonExt.toEncodable].
extension SizeJsonExt on Size {
  List<int> get json => [width.round(), height.round()];
}
