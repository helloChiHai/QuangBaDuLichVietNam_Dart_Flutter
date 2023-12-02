import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/deleteAccount/bloc/deleteAccount_bloc.dart';
import 'package:userappquanbadulich/deleteAccount/bloc/deleteAccount_event.dart';

class DeleteAccount_Widget extends StatefulWidget {
  final String customerId;

  const DeleteAccount_Widget({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<DeleteAccount_Widget> createState() => _DeleteAccount_WidgetState();
}

class _DeleteAccount_WidgetState extends State<DeleteAccount_Widget> {
  late String idCus;
  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

  @override
  Widget build(BuildContext context) {
    final deleteAccountBloc = BlocProvider.of<DeleteAccountBloc>(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          color: const Color.fromARGB(255, 242, 239, 239),
          child: const Image(
            image: AssetImage('assets/img/img_12.png'),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ủa tính nghỉ chơi VietWander thiệt hả?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Lưu ý: Tài khoản sau khi xóa sẽ không thể phục hồi lại được.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Bạn sẽ mất tất cả thông tin cá nhân bao gồm ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 98, 98, 98),
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: 'địa điểm du lịch yêu thích.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sau khi xóa tài khoản, bạn sẽ ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 98, 98, 98),
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text:
                          'không thể dùng lại email và số điện thoại của tài khoản này để tạo tài khoản mới luôn nha bạn yêu.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Bộ phận CSKH của VietWander sẽ không thể hỗ trợ bạn phục hồi tài khoản.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Thôi không xóa nữa',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    deleteAccountBloc.add(
                      DeleteAccountButtonPressed(
                        idCus: idCus,
                      ),
                    );
                  },
                  child: const Text(
                    'Xóa tài khoản này',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
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
