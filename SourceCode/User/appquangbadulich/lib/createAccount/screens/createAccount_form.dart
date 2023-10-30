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

  bool _obscureText_mk = true;
  bool _obscureText_nlmk = true;
  @override
  Widget build(BuildContext context) {
    final createAccountBloc = BlocProvider.of<CreateAccountBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Container(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/login');
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
            image: AssetImage('assets/img/img_5.png'),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Tạo Tài Tài Khoản',
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
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(fontSize: 18, color: Colors.black),
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
            obscureText: _obscureText_mk,
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText_mk ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText_mk = !_obscureText_mk;
                  });
                },
              ),
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
            obscureText: _obscureText_nlmk,
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Nhập lại mật khẩu',
              labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText_nlmk ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText_nlmk = !_obscureText_nlmk;
                  });
                },
              ),
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
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Họ tên',
              labelStyle: TextStyle(fontSize: 18, color: Colors.black),
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
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'Địa chỉ',
              labelStyle: TextStyle(fontSize: 18, color: Colors.black),
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
            controller: birthdayController,
            decoration: const InputDecoration(
              labelText: 'Ngày sinh',
              labelStyle: TextStyle(fontSize: 18, color: Colors.black),
              border: InputBorder.none,
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
                final confirmPassword = confirmPasswordController.text;
                final name = nameController.text;
                final address = addressController.text;
                final birthday = birthdayController.text;

                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập Email!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập Mật Khẩu!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (confirmPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập Xác Nhận Mật Khẩu!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập lại Họ Tên!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (address.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập lại Địa Chỉ!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (birthday == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập lại Ngày sinh!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mật khẩu trong trùng khớp!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  createAccountBloc.add(
                    CreateAccontButtonPressed(
                      email: email,
                      password: password,
                      name: name,
                      imgCus: "",
                      address: address,
                      birthday: birthday,
                      role: 1,
                    ),
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Tạo tài khoản',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
