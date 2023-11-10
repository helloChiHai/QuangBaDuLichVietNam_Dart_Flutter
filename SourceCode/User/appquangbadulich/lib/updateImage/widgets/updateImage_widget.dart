import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateImageWidget extends StatefulWidget {
  const UpdateImageWidget({super.key});

  @override
  State<UpdateImageWidget> createState() => _UpdateImageWidgetState();
}

class _UpdateImageWidgetState extends State<UpdateImageWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 280,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Thêm sắc màu cho hồ sơ của bạn! Hãy chọn một hình ảnh tuyệt vời từ thư viện của bạn ngay bây giờ. Nhấn vào nút dưới để bắt đầu!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Cập nhật',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
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
                        print(isCheckUploadImg);
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
          ),
        ],
      ),
    );
  }
}
