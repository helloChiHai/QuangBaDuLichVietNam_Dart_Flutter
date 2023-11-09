import 'package:flutter/material.dart';

class EditAccount_Gmail_Page extends StatefulWidget {
  const EditAccount_Gmail_Page({Key? key,
  }) : super(key: key);

  @override
  State<EditAccount_Gmail_Page> createState() => _EditAccount_Gmail_PageState();
}

class _EditAccount_Gmail_PageState extends State<EditAccount_Gmail_Page> {
  String emailHienTai = '';
  String thongBaoLoi = '';

    
  @override
  void initState() {
    super.initState();
  }

  bool validateEmail(String input) {
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // Biểu thức chính quy kiểm tra địa chỉ email
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Thay đổi email',
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
          icon: const Icon(Icons.close), // Thay đổi icon thành 'x'
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 25,
        ),
        child: Column(
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
                                thongBaoLoi = 'Không phải email, Vui lòng nhập lại.';
                              } else {
                                thongBaoLoi = '';
                                print(emailHienTai);
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
        ),
      ),
    );
  }
}