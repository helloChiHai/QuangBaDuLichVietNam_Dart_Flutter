import 'package:appquangbadulich/login/bloc/login_bloc/login_bloc.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  const LoginScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            userRepository: userRepository,
          );
        },
        // child: LoginForm(userRepository: userRepository),
      ),
    );
  }
}
