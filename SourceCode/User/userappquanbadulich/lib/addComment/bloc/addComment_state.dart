import 'package:equatable/equatable.dart';

abstract class AddCommentState extends Equatable {
  const AddCommentState();
  @override
  List<Object?> get props => [];
}

class AddCommentInitial extends AddCommentState {}

class AddCommentLoading extends AddCommentState {}

class AddCommentSuccess extends AddCommentState {
  final String message;
  AddCommentSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class AddCommentFailure extends AddCommentState {
  final String error;
  AddCommentFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
