import 'package:equatable/equatable.dart';

abstract class UpdateCommentState extends Equatable {
  const UpdateCommentState();
  @override
  List<Object?> get props => [];
}

class UpdateCommentInitial extends UpdateCommentState {}

class UpdateCommentLoading extends UpdateCommentState {}

class UpdateCommentSuccess extends UpdateCommentState {
  final String message;
  UpdateCommentSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class UpdateCommentFailure extends UpdateCommentState {
  final String error;
  UpdateCommentFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
