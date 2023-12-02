import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/deleteAccount/bloc/deleteAccount_bloc.dart';
import 'package:userappquanbadulich/deleteAccount/bloc/deleteAccount_state.dart';
import 'package:userappquanbadulich/deleteAccount/widgets/deleteAccount_widget.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
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
        backgroundColor: const Color.fromARGB(255, 242, 239, 239),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: BlocListener<DeleteAccountBloc, DeleteAccountState>(
        listener: (context, state) {
          if (state is DeleteAccountSuccess && !isDialogShown) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Xóa tài khoản thành công!',
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
                    'Xóa tài khoản thành công! Hẹn gặp lại bạn',
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
          } else if (state is DeleteAccountFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Xóa tài khoản không thành công!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: DeleteAccount_Widget(customerId: customerId),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
