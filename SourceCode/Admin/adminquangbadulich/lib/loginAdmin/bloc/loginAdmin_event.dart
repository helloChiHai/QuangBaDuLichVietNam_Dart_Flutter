import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginAdminEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginAdminButtonPressed extends LoginAdminEvent {
  final String account;
  final String password;

  LoginAdminButtonPressed({required this.account, required this.password});

  @override
  List<Object?> get props => [account, password];
}
