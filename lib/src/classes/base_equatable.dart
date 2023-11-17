import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class BaseEquatable extends Equatable {
  const BaseEquatable();

  int get shrinkToString => 120;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    final s = props.join('\t');
    late final String data;
    if (shrinkToString > 0) {
      data = s.substring(0, min(shrinkToString, s.length)) +
          (s.length > shrinkToString ? '...' : '');
    } else {
      data = s;
    }

    return '$runtimeType $data';
  }
}
