import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/createAccount/bloc/createAccount_bloc.dart';

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

  bool _obscureText_mk = true;
  bool _obscureText_nlmk = true;

  bool validateEmail(String input) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(input);
  }

  bool isValidPassword(String password) {
    if (password.length < 6) {
      return false;
    }
    // Kiểm tra có chữ cái in hoa
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    // Kiểm tra có chữ cái thường
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    // Kiểm tra có số
    bool hasDigit = password.contains(RegExp(r'[0-9]'));
    // Trả về kết quả tổng cộng các điều kiện
    return hasUppercase && hasLowercase && hasDigit;
  }

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
            image: AssetImage('assets/img/img_intro_2.png'),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'Tạo Tài Khoản',
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
              hintText: 'vietwander123@gmail.com',
              hintStyle: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 113, 112, 112)),
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
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Mật khẩu',
              labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
              border: InputBorder.none,
              hintText: 'Vietwander123',
              hintStyle: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 113, 112, 112)),
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
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Nhập lại mật khẩu',
              labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
              border: InputBorder.none,
              hintText: 'Vietwander123',
              hintStyle: const TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 113, 112, 112)),
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
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              labelText: 'Họ tên',
              labelStyle: TextStyle(fontSize: 20, color: Colors.black),
              border: InputBorder.none,
              hintText: 'Vương Chí Hải',
              hintStyle: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 113, 112, 112)),
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
                } else if (!validateEmail(email)) {
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Email không đúng định dạng',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else if (password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Vui lòng nhập Mật Khẩu!',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (!isValidPassword(password)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mật khẩu không hợp lệ. Yêu cầu ít nhất một chữ cái in hoa, một chữ cái thường, một số, và độ dài ít nhất 6 ký tự.',
                        style: TextStyle(
                          fontSize: 18,
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
                } else if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mật khẩu trong trùng khớp!',
                        style: TextStyle(
                          fontSize: 18,
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
                          fontSize: 18,
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
                      address: "",
                      birthday: "",
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

  @override
  void dispose() {
    super.dispose();
  }
}
