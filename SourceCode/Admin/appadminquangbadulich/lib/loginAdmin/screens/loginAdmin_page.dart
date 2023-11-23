import 'package:appadminquangbadulich/homeAdmin/screens/homeAdmin_page.dart';
import 'package:appadminquangbadulich/loginAdmin/bloc/loginAdmin_bloc.dart';
import 'package:appadminquangbadulich/loginAdmin/bloc/loginAdmin_state.dart';
import 'package:appadminquangbadulich/loginAdmin/screens/loginAdmin_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAdminPage extends StatelessWidget {
  const LoginAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginAdminBloc, LoginAdminState>(
        listener: (context, state) {
          if (state is LoginAdminSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Đăng nhập thành công!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.green,
            ));
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdminPage(),));
          } else if (state is LoginAdminFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sai Email hoặc mật khẩu!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(child: LoginAdminForm()),
      ),
    );
  }
}
