import 'dart:async';

import 'package:flutter/material.dart';

class CreateAccountSuccessful extends StatefulWidget {
  const CreateAccountSuccessful({super.key});

  @override
  State<CreateAccountSuccessful> createState() =>
      _CreateAccountSuccessfulState();
}

class _CreateAccountSuccessfulState extends State<CreateAccountSuccessful> {
  int countdown = 5;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountdonwn();
  }

  void startCountdonwn() {
    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
        } else {
          Navigator.of(context).pushNamed('/login');
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: const Text(
                  'Cùng khám phá đất nước, văn hóa, lịch sử con người Việt Nam nhé!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: Text(
                  'Đăng nhập ($countdown s)',
                  style: const TextStyle(
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
