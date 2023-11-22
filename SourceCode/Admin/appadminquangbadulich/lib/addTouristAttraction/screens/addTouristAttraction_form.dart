import 'dart:convert';
import 'dart:io';

import 'package:appadminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/addTouristAttraction_event.dart';

class AddTouristAttractionForm extends StatefulWidget {
  AddTouristAttractionForm({super.key});

  @override
  State<AddTouristAttractionForm> createState() =>
      _AddTouristAttractionFormState();
}

class _AddTouristAttractionFormState extends State<AddTouristAttractionForm> {
  bool isCheckUploadImg = false;
  String? imagePath;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final PickedFile? pickedFile =
        await _imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isCheckUploadImg = true;
        imagePath = pickedFile.path;
      });
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  @override
  Widget build(BuildContext context) {
    final addTouristAttractionBloc =
        BlocProvider.of<AddTouristAttractionBloc>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Tên địa điểm',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Loại địa điểm',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Địa chỉ',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Giá vé',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hình ảnh',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isCheckUploadImg = !isCheckUploadImg;
                });
              },
              child: isCheckUploadImg
                  ? Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                        image: isCheckUploadImg && imagePath != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(imagePath!)),
                              )
                            : null,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(169, 169, 169, 0.5),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Giới thiệu về địa điểm',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thời điểm thích hợp',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            // LỊCH SỬ
            const SizedBox(height: 20),
            const Text(
              'Lịch sử',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              'Tên sự kiện lịch sử',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nội dung',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ảnh đại diện cho sự kiện',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hình ảnh cho sự kiện(nếu có)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Video của sự kiện(nếu có)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),

            // VĂN HÓA
            const SizedBox(height: 20),
            const Text(
              'Văn hóa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              'Tên văn hóa',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nội dung văn hóa',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            const Text(
              'Hình ảnh cho văn hóa(nếu có)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Video của văn hóa(nếu có)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),

            // ẨM THỰC
            const SizedBox(height: 20),
            const Text(
              'Đặc sản của địa điểm',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              'Tên món',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Địa chỉ của quán',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            const Text(
              'Hình ảnh cho văn hóa(nếu có)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            const Text(
              'Giới thiệu về món ăn',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: null, // Cho phép nhiều dòng
                expands: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                  onPressed: () {},
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
        ),
      ),
    );
  }
}
