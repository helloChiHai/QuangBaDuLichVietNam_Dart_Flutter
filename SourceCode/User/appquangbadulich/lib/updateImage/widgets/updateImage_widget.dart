import 'dart:io';

import 'package:appquangbadulich/updateImage/widgets/displayimg_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class UpdateImageWidget extends StatefulWidget {
  const UpdateImageWidget({Key? key}) : super(key: key);

  @override
  State<UpdateImageWidget> createState() => _UpdateImageWidgetState();
}

class _UpdateImageWidgetState extends State<UpdateImageWidget> {
  bool isCheckUploadImg = false;
  String? imagePath;
  List<String> savedImagePaths = [];
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

  Future<void> _updateImage(BuildContext context) async {
    if (imagePath != null) {
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String imgDirectoryPath =
          path.join(appDirectory.path, 'assets/img/');

      if (!Directory(imgDirectoryPath).existsSync()) {
        Directory(imgDirectoryPath).createSync(recursive: true);
      }

      final String fileName = path.basename(imagePath!);

      final String newPath = path.join(imgDirectoryPath, fileName);

      await File(imagePath!).copy(newPath);

      // Thêm đường dẫn mới vào danh sách
      savedImagePaths.add(newPath);

      // Hiển thị Snackbar khi hình ảnh được lưu thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hình ảnh đã được lưu tại: $newPath'),
        ),
      );
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
                // GestureDetector(
                //   onTap: () {
                //     _updateImage(context);
                //     print('Đây là tên file ảnh: ${path.basename(imagePath!)}');
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 30,
                //       vertical: 10,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.blue,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: const Text(
                //       'Cập nhật',
                //       style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () {
                    _updateImage(context);
                    print('Đây là tên file ảnh: ${path.basename(imagePath!)}');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DisplayWidget(imagePaths: savedImagePaths),
                      ),
                    );
                  },
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
                      'Xem hình ảnh',
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
