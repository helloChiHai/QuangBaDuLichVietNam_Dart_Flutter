import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:userappquanbadulich/updateImage/bloc/updateImage_event.dart';
import 'package:userappquanbadulich/updateImage/widgets/displayimg_widget.dart';

import '../bloc/updateImage_bloc.dart';

class UpdateImageWidget extends StatefulWidget {
  final String customerId;
  const UpdateImageWidget({Key? key, required this.customerId})
      : super(key: key);

  @override
  State<UpdateImageWidget> createState() => _UpdateImageWidgetState();
}

class _UpdateImageWidgetState extends State<UpdateImageWidget> {
  late String idCus;

  @override
  void initState() {
    super.initState();
    idCus = widget.customerId;
  }

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

  Future<void> _updateImage() async {
    if (imagePath != null) {
      // Lấy đường dẫn đến thư mục lưu trữ dữ liệu cục bộ
      final appDocDir = await getApplicationDocumentsDirectory();
      final String localPath = appDocDir.path;

      // Tạo tên file mới
      final String fileName = path.basename(imagePath!);
      final String newFilePath = '$localPath/$fileName';

      print('day la duong dan: ${newFilePath}');

      // Di chuyển hình ảnh vào thư mục mới
      await File(imagePath!).copy(newFilePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final updateImageBloc = BlocProvider.of<UpdateImageBloc>(context);

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
                  onTap: ()  {
                  

                    print('Đây là tên file ảnh: ${path.basename(imagePath!)}');
                    _updateImage();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DisplayWidget(imagePaths: imagePath),
                      ),
                    );
                    updateImageBloc.add(
                      UpdateImageButtonPressed(
                        idCus: idCus,
                        newImage: imagePath!,
                      ),
                    );
                    print(imagePath);
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
                      'Cập nhật hình ảnh',
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
