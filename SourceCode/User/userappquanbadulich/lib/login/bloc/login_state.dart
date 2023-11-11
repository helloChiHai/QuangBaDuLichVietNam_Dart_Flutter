import 'package:equatable/equatable.dart';

import '../../model/CustomerModel.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final CustomerModel customer;

  LoginSuccess({required this.customer});

  @override
  List<Object?> get props => [customer];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
