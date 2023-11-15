import 'package:equatable/equatable.dart';

abstract class CheckCommentOwnerShipState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckCommentOwnerInitial extends CheckCommentOwnerShipState {}

class CheckCommentOwnerLoading extends CheckCommentOwnerShipState {}

class CheckCommentOwnerSuccess extends CheckCommentOwnerShipState {
  final int result;
  CheckCommentOwnerSuccess({required this.result});
  @override
  List<Object?> get props => [result];
}

class CheckCommentOwnerError extends CheckCommentOwnerShipState {
  final String error;
  CheckCommentOwnerError({required this.error});
  @override
  List<Object?> get props => [error];
}
