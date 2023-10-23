import 'package:appquangbadulich/createAccount/bloc/createAccount_bloc.dart';
import 'package:appquangbadulich/createAccount/bloc/createAccount_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'createAccount_form.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo tài khoản'),
      ),
      body: BlocListener<CreateAccountBloc, CreateAccountState>(
        listener: (context, state) {
          if (state is CreateAccountSuccess) {
            print('Tạo tài khoản thành công');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tạo tài khoản thành công'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is CreateAccountFailure) {
            print(state.error);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: CreateAccountForm(),
      ),
    );
  }
}
