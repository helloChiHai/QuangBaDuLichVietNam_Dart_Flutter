import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appquangbadulich/login/bloc/login_bloc/login_bloc.dart';
import 'package:appquangbadulich/login/bloc/login_bloc/login_event.dart';

class LoginForm extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logBloc = BlocProvider.of<LoginBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        ElevatedButton(
          onPressed: () {
            final email = emailController.text;
            final password = passwordController.text;
            print(email + " and " + password);
            logBloc.add(LoginButtonPressed(email: email, password: password));
          },
          child: const Text('Đăng nhập'),
        ),
      ],
    );
  }
}
