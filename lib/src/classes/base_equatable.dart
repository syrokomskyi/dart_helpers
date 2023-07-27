import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class BaseEquatable extends Equatable {
  const BaseEquatable();

  int get shrinkToString => 100;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    final s = props.join('\t');
    final data = s.substring(0, min(shrinkToString, s.length)) +
        (s.length > shrinkToString ? '...' : '');

    return '$runtimeType $data';
  }
}
