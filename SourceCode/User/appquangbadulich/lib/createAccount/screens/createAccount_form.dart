import 'package:appquangbadulich/createAccount/bloc/createAccount_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/createAccount_event.dart';

class CreateAccountForm extends StatefulWidget {
  CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final birthdayController = TextEditingController();
  bool isErrorPass = false;

  @override
  Widget build(BuildContext context) {
    final createAccountBloc = BlocProvider.of<CreateAccountBloc>(context);
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
        TextField(
          controller: confirmPasswordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: addressController,
          decoration: const InputDecoration(labelText: 'Address'),
        ),
        TextField(
          controller: birthdayController,
          decoration: const InputDecoration(labelText: 'BirthDay'),
        ),
        isErrorPass
            ? const Text('Mật khẩu không trùng khớp')
            : const SizedBox(),
        ElevatedButton(
          onPressed: () {
            final email = emailController.text;
            final password = passwordController.text;
            final confirmPassword = confirmPasswordController.text;
            final name = nameController.text;
            final address = addressController.text;
            final birthday = birthdayController.text;

            if (password == confirmPassword) {
              createAccountBloc.add(
                CreateAccontButtonPressed(
                  email: email,
                  password: password,
                  name: name,
                  address: address,
                  birthday: birthday,
                ),
              );
            } else {
              setState(() {
                isErrorPass = true;
              });
            }
          },
          child: const Text('Tạo tài khoản'),
        ),
      ],
    );
  }
}
