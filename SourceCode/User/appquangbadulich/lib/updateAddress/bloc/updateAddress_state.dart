import 'package:appquangbadulich/model/CustomerModel.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateAddressState extends Equatable {
  const UpdateAddressState();
  @override
  List<Object?> get props => [];
}

class UpdateAddressInitial extends UpdateAddressState {}

class UpdateAddressLoading extends UpdateAddressState {}

class UpdateAddressSuccess extends UpdateAddressState {
  final CustomerModel customer;
  UpdateAddressSuccess({required this.customer});
  @override
  List<Object?> get props => [customer];
}

class UpdateAddressFailure extends UpdateAddressState {
  final String error;
  UpdateAddressFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
