import 'package:appquangbadulich/model/CustomerModel.dart';
import 'package:equatable/equatable.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();
  @override
  List<Object?> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoading extends UpdatePasswordState {}

class UpdatePasswordSuccess extends UpdatePasswordState {
  final CustomerModel customer;
  UpdatePasswordSuccess({required this.customer});
  @override
  List<Object?> get props => [customer];
}

class UpdatePasswordFailure extends UpdatePasswordState {
  final String error;
  UpdatePasswordFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
