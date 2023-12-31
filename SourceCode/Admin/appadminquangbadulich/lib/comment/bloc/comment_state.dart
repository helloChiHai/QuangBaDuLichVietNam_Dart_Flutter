import 'package:appadminquangbadulich/model/commentModel.dart';
import 'package:equatable/equatable.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentModel> comments;
  CommentLoaded({required this.comments});
  @override
  List<Object?> get props => [comments];
}

class CommentFailure extends CommentState {
  final String error;
  CommentFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
