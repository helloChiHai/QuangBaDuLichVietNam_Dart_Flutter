import 'package:flutter/material.dart';

class EditAccount_Name_Page extends StatefulWidget {
  EditAccount_Name_Page({Key? key}) : super(key: key);

  @override
  State<EditAccount_Name_Page> createState() =>
      _EditAccount_Name_PageState();
}

class _EditAccount_Name_PageState extends State<EditAccount_Name_Page> {
  String ten = '';
  String IDnguoiDung = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        title: const Text(
          'Thay đổi tên',
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
              'Tên',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: ten,
                hintStyle: const TextStyle(
                  color: Colors.black,
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
                    ten = value;
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ten.isEmpty
                ? const Text(
                    'Tên không hợp lệ, vui lòng kiểm tra lại',
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
                    onPressed: ten.isEmpty ? null : () {
                      print(ten);
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
