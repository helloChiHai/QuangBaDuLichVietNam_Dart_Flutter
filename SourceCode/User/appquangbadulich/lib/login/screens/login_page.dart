import 'package:appquangbadulich/login/bloc/login_bloc.dart';
import 'package:appquangbadulich/login/bloc/login_state.dart';
import 'package:appquangbadulich/login/screens/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Đăng nhập thành công!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.green,
            ));
            Future.delayed(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pushNamed('/home');
              },
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sai Email hoặc mật khẩu!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(child: LoginForm()),
      ),
    );
  }
}
