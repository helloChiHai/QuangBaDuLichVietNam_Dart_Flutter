import 'package:appadminquangbadulich/model/CustomerModel.dart';
import 'package:equatable/equatable.dart';

abstract class UserManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class UserManagementLoading extends UserManagementState {}

class UserManagementLoaded extends UserManagementState {
  final List<CustomerModel> user;
  UserManagementLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

class UserManagementFailure extends UserManagementState {
  final String error;
  UserManagementFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
