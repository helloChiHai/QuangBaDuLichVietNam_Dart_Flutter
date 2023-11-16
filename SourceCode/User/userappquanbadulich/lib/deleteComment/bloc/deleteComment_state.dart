import 'package:equatable/equatable.dart';

abstract class DeleteCommentState extends Equatable {
  const DeleteCommentState();
  @override
  List<Object?> get props => [];
}

class DeleteCommentInitial extends DeleteCommentState {}

class DeleteCommentLoading extends DeleteCommentState {}

class DeleteCommentSuccess extends DeleteCommentState {
  final String message;
  DeleteCommentSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class DeleteCommentFailure extends DeleteCommentState {
  final String error;
  DeleteCommentFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
