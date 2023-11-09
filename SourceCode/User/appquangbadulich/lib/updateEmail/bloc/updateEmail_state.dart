import 'package:appquangbadulich/model/CustomerModel.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateEmailState extends Equatable {
  const UpdateEmailState();
  @override
  List<Object?> get props => [];
}

class UpdateEmailInitial extends UpdateEmailState {}

class UpdateEmailLoading extends UpdateEmailState {}

class UpdateEmailSuccess extends UpdateEmailState {
  final CustomerModel customer;
  UpdateEmailSuccess({required this.customer});
  @override
  List<Object?> get props => [customer];
}

class UpdateEmailFailure extends UpdateEmailState {
  final String error;
  UpdateEmailFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
