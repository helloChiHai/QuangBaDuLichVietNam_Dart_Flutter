import 'package:flutter/material.dart';

class EditAccount_Password_Page extends StatefulWidget {

  EditAccount_Password_Page({
    Key? key,
  }) : super(key: key);

  @override
  State<EditAccount_Password_Page> createState() => _EditAccount_Password_PageState();
}

class _EditAccount_Password_PageState extends State<EditAccount_Password_Page> {
  String matKhauMoi = '';
  String xacNhanMatKhauMoi = '';
  bool hienThiThongBaoLoi_doDai = false;
  bool hienThiThongBaoLoi_trungKhopMatKhau = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Thay đổi mật khẩu',
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
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
                    onPressed: (){
                      print('Mật khẩu mới: ${matKhauMoi}');
                      print('Mật khẩu mới: ${xacNhanMatKhauMoi}');
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