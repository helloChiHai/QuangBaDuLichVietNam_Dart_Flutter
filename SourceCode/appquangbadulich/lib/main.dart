import 'package:appquangbadulich/login/bloc/login_bloc/login_bloc.dart';
import 'package:appquangbadulich/login/bloc/login_bloc/login_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/screens/auth/login_form.dart';

class MyApp extends StatelessWidget {
  final userRepository = UserRepository();
  final logBloc = LoginBloc(userRepository: UserRepository());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => logBloc,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Bloc Login Example'),
          ),
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginInitial) {
                return LoginForm(); 
              } else if (state is LoginLoading) {
                return const CircularProgressIndicator();
              } else if (state is LoginSuccess) {
                return Text('Đăng nhập thành công: ${state.customer.name}');
              } else if (state is LoginFailure) {
                return Text('Đăng nhập thất bạiiii: ${state.error}');
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  final userRepository = UserRepository();
  final loginBloc = LoginBloc(userRepository: userRepository);

  runApp(
    BlocProvider(
      create: (context) => loginBloc,
      child: MyApp(),
    ),
  );
}
