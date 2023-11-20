import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/updateEmail_bloc.dart';
import '../bloc/updateEmail_event.dart';

class UpdateEmailForm extends StatefulWidget {
  final String customerId;
  const UpdateEmailForm({Key? key, required this.customerId}) : super(key: key);

  @override
  State<UpdateEmailForm> createState() => _UpdateEmailFormState();
}

class _UpdateEmailFormState extends State<UpdateEmailForm> {
  String emailHienTai = '';
  String thongBaoLoi = '';
  late String idCus;

  bool validateEmail(String input) {
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(input);
  }

  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

  @override
  Widget build(BuildContext context) {
    final updateEmailBloc = BlocProvider.of<UpdateEmailBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Địa chỉ Email',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: emailHienTai,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          onChanged: (value) {
            setState(() {
              emailHienTai = value;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        emailHienTai.isEmpty
            ? const Text(
                'Vui lòng nhập email.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              )
            : thongBaoLoi.isNotEmpty
                ? Text(
                    thongBaoLoi,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  )
                : const SizedBox(),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: emailHienTai.isEmpty
                    ? null
                    : () {
                        setState(() {
                          if (emailHienTai.isEmpty) {
                            thongBaoLoi = 'Vui lòng nhập email.';
                          } else if (!validateEmail(emailHienTai)) {
                            thongBaoLoi =
                                'Không phải email, Vui lòng nhập lại.';
                          } else {
                            thongBaoLoi = '';
                            print(idCus);
                            print(emailHienTai);
                            updateEmailBloc.add(
                              UpdateEmailButtonPressed(
                                idCus: idCus,
                                newEmail: emailHienTai,
                              ),
                            );
                          }
                        });
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
}
