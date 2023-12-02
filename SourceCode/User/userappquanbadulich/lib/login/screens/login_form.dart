import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/login/bloc/login_bloc.dart';
import 'package:userappquanbadulich/login/bloc/login_event.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final logBloc = BlocProvider.of<LoginBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/intro_login');
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 30),
        const SizedBox(
          width: double.infinity,
          height: 230,
          child: Image(
            image: AssetImage('assets/img/img_intro_3.png'),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Đăng Nhập',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          width: 0.9 * MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            controller: emailController,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 20, color: Colors.black),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 0.9 * MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: TextField(
            obscureText: _obscureText,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 0.9 * MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              if (email.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Vui lòng nhập Email!',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Vui lòng nhập mật khẩu!',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (email.isEmpty && password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Vui lòng nhập Email và mật khẩu!',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                logBloc.add(
                  LoginButtonPressed(email: email, password: password),
                );
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Bạn quên mật khẩu?',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bạn chưa có tài khoản?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/createAccount');
                },
                child: const Text(
                  'Đăng ký tài khoản',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
