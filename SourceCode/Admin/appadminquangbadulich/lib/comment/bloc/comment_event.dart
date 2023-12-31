import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object?> get props => [];
}

class LoadComment extends CommentEvent {
  final String idTourist;
  LoadComment({required this.idTourist});
  @override
  List<Object?> get props => [idTourist];
}
