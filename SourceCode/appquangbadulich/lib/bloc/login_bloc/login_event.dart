import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonpressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonpressed({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() {
    return 'LoginButtonPressed{email: $email, password: $password}';
  }
}
