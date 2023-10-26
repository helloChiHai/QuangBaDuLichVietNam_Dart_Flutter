import 'package:flutter/material.dart';

class LoginSignUpSuccessful extends StatefulWidget {
  const LoginSignUpSuccessful({super.key});

  @override
  State<LoginSignUpSuccessful> createState() => _LoginSignUpSuccessfulState();
}

class _LoginSignUpSuccessfulState extends State<LoginSignUpSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const SizedBox(
                width: double.infinity,
                height: 230,
                child: Image(
                  image: AssetImage('assets/img/img_7.gif'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Tạo Tài Khoản Thành Công',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Cùng khám phá đất nước, văn hóa, lịch sử con người Việt Nam nhé!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.of(context).pushNamed('/login');
                  });
                },
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
