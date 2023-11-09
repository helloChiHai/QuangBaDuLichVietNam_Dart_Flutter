import 'package:appquangbadulich/model/CustomerModel.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateBirthdayState extends Equatable {
  const UpdateBirthdayState();
  @override
  List<Object?> get props => [];
}

class UpdateBirthdayInitial extends UpdateBirthdayState {}

class UpdateBirthdayLoading extends UpdateBirthdayState {}

class UpdateBirthdaySuccess extends UpdateBirthdayState {
  final CustomerModel customer;
  UpdateBirthdaySuccess({required this.customer});
  @override
  List<Object?> get props => [customer];
}

class UpdateBirthdayFailure extends UpdateBirthdayState {
  final String error;
  UpdateBirthdayFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
