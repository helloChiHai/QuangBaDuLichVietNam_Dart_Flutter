import 'package:appquangbadulich/updateBirthday/bloc/updateBirthday_bloc.dart';
import 'package:appquangbadulich/updateBirthday/bloc/updateBirthday_state.dart';
import 'package:appquangbadulich/updateBirthday/screens/updateBrithday_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBirthdayPage extends StatefulWidget {
  const UpdateBirthdayPage({
    Key? key,
  }) : super(key: key);

  @override
  _UpdateBirthdayPageState createState() => _UpdateBirthdayPageState();
}

class _UpdateBirthdayPageState extends State<UpdateBirthdayPage> {
  late String customerId;
  bool isDialogShown = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    customerId = args['customerId'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Ngày sinh',
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: BlocListener<UpdateBirthdayBloc, UpdateBirthdayState>(
        listener: (context, state) {
          if (state is UpdateBirthdaySuccess && !isDialogShown) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật Birthday thành công!',
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
                  title: const Text(
                    'Cập nhật Birthday thành công! Vui lòng đăng nhập lại để hoàn tất việc cập nhật',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: const Text(
                        'OK',
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
          } else if (state is UpdateBirthdayFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật Birthday không thành công!',
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
          child: UpdateBirthdayForm(customerId: customerId),
        ),
      ),
    );
  }
}
