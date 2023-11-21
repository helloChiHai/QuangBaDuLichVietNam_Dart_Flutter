import 'package:appadminquangbadulich/model/adminModel.dart';
import 'package:equatable/equatable.dart';

abstract class LoginAdminState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginAdminInitial extends LoginAdminState {}

class LoginAdminLoading extends LoginAdminState {}

class LoginAdminSuccess extends LoginAdminState {
  final AdminModel admin;

  LoginAdminSuccess({required this.admin});

  @override
  List<Object?> get props => [admin];
}

class LoginAdminFailure extends LoginAdminState {
  final String error;

  LoginAdminFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
