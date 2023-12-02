import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/updatePassword_bloc.dart';
import '../bloc/updatePassword_event.dart';

class UpdatePasswordForm extends StatefulWidget {
  final String customerId;

  const UpdatePasswordForm({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<UpdatePasswordForm> createState() => _UpdatePasswordFormState();
}

class _UpdatePasswordFormState extends State<UpdatePasswordForm> {
  String matKhauMoi = '';
  String xacNhanMatKhauMoi = '';
  bool hienThiThongBaoLoi_doDai = false;
  bool hienThiThongBaoLoi_trungKhopMatKhau = false;
  late String idCus;
  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

  @override
  Widget build(BuildContext context) {
    final updatePaswordBloc = BlocProvider.of<UpdatePasswordBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mật khẩu mới',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 88, 88, 88),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Nhập mật khẩu mới',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          onChanged: (value) {
            setState(
              () {
                matKhauMoi = value.isEmpty ? '' : value;
                hienThiThongBaoLoi_doDai = matKhauMoi.length < 6;
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        hienThiThongBaoLoi_doDai
            ? const Text(
                'Độ dài tối thiểu là 6 ký tự',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Xác nhận khẩu mới',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 88, 88, 88),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Xác nhận mật khẩu',
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          onChanged: (value) {
            setState(
              () {
                xacNhanMatKhauMoi = value.isEmpty ? '' : value;
                hienThiThongBaoLoi_trungKhopMatKhau =
                    (xacNhanMatKhauMoi != matKhauMoi);
              },
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        hienThiThongBaoLoi_trungKhopMatKhau
            ? const Text(
                'Mật khẩu không trùng khớp',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              )
            : const SizedBox(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Mật khẩu mới: ${matKhauMoi}');
                  print('Mật khẩu mới: ${xacNhanMatKhauMoi}');
                  updatePaswordBloc.add(
                    UpdatePasswordButtonPressed(
                      idCus: idCus,
                      newPassword: xacNhanMatKhauMoi,
                    ),
                  );
                },
                child: const Text(
                  'Lưu',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
