import 'dart:async';

import 'package:appquangbadulich/updateEmail/bloc/updateEmail_bloc.dart';
import 'package:appquangbadulich/updateEmail/bloc/updateEmail_state.dart';
import 'package:appquangbadulich/updateEmail/screens/updateEmail_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  late String customerId;
  int countdown = 5;
  late Timer timer;
  bool isDialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    customerId = args['customerId'] as String;
  }

  void startCountdonwn() {
    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      setState(() {
        if (countdown > 0) {
          countdown--;
          print(countdown);
        } else {
          // Navigator.of(context).pushNamed('/login');
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
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Thay đổi email',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<UpdateEmailBloc, UpdateEmailState>(
        listener: (context, state) {
          if (state is UpdateEmailSuccess && !isDialogShown) {
            startCountdonwn();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật Email thành công!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Cập nhật Email thành công! Vui lòng đăng nhập lại để hoàn tất việc cập nhật',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK ($countdown s)',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is UpdateEmailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật Email không thành công!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 25,
          ),
          child: UpdateEmailForm(customerId: customerId),
        ),
      ),
    );
  }
}
