import 'dart:math';

import 'package:equatable/equatable.dart';

abstract class BaseEquatable extends Equatable {
  const BaseEquatable([this.shrinkStringTo = 100]);

  final int shrinkStringTo;

  @override
  List<Object?> get props => [];

  @override
  String toString() {
    final s = props.join('\t');
    final data = s.substring(0, min(shrinkStringTo, s.length)) +
        (s.length > shrinkStringTo ? '...' : '');

    return '$runtimeType $data';
  }
}
