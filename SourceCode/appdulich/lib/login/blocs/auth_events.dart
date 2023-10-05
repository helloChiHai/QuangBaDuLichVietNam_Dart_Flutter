import 'package:equatable/equatable.dart';

class AuthEvents extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartEvent extends AuthEvents {}

class LoginButtonPressed extends AuthEvents {
  final String account;
  final String password;

  LoginButtonPressed({required this.account, required this.password});
}
