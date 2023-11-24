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
  final ImagePicker _imagePickerTouristAttraction = ImagePicker();
  final ImagePicker _imagePickerAvatarHistory = ImagePicker();
  final ImagePicker _imagePickerimgHistory = ImagePicker();
  final ImagePicker _imagePickerimgCulture = ImagePicker();
  final ImagePicker _imagePickerimgDish = ImagePicker();

  bool isCheckUploadfileVideoPickerResultCulture = false;
  bool isCheckUploadfileVideoPickerResultHistory = false;
  bool isCheckUploadImgTouristAttraction = false;
  bool isCheckUploadImgAvatarHistory = false;
  bool isCheckUploadImgimgHistory = false;
  bool isCheckUploadImgimgCulture = false;
  bool isCheckUploadImgimgDish = false;

  String? videoPathfilePickerResultCulture;
  String? videoPathfilePickerResultHistory;
  String? imagePathTouristAttraction;
  String? imagePathAvatarHistory;
  String? imagePathimgHistory;
  String? imagePathimgCulture;
  String? imagePathimgDish;
  // tourist attraction
  String nameTourist = '';
  String typeTourist = '';
  String address = '';
  String ticket = '';
  String touristIntroduction = '';
  String rightTime = '';
  // history
  String titleStoryStory = '';
  String contentStoryStory = '';
  // culture
  String titleCulture = '';
  String contentCulture = '';
  // specialtyDish
  String nameDish = '';
  String addressDish = '';
  String dishIntroduction = '';
  List? comment;

  Future<void> _pickImage(ImagePicker imagePicker, String type) async {
    final PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (type == 'imgTourist') {
        setState(() {
          isCheckUploadImgTouristAttraction = true;
          imagePathTouristAttraction = pickedFile.path;
        });
      } else if (type == 'avatarHistory') {
        setState(() {
          isCheckUploadImgAvatarHistory = true;
          imagePathAvatarHistory = pickedFile.path;
        });
      } else if (type == 'imgHistory') {
        setState(() {
          isCheckUploadImgimgHistory = true;
          imagePathimgHistory = pickedFile.path;
        });
      } else if (type == 'imgCulture') {
        setState(() {
          isCheckUploadImgimgCulture = true;
          imagePathimgCulture = pickedFile.path;
        });
      } else if (type == 'imgDish') {
        setState(() {
          isCheckUploadImgimgDish = true;
          imagePathimgDish = pickedFile.path;
        });
      }
    }
  }

  // Future<void> _pickVideo(String type) async {
  //   try {
  //     FilePickerResult? pickedFile =
  //         await FilePicker.platform.pickFiles(type: FileType.video);

  //     if (pickedFile != null) {
  //       if (type == 'videoHistory') {
  //         setState(() {
  //           isCheckUploadfileVideoPickerResultHistory = true;
  //           videoPathfilePickerResultHistory = pickedFile.files.single.path;
  //         });
  //       } else if (type == 'videoCulture') {
  //         setState(() {
  //           isCheckUploadfileVideoPickerResultCulture = true;
  //           videoPathfilePickerResultCulture = pickedFile.files.single.path;
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Error picking video: $e');
  //   }
  // }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<void> createTouristAttraction() async {
    final updateImageBloc = BlocProvider.of<AddTouristAttractionBloc>(context);

    Future<String> getBase64Data(String? imagePath) async {
      if (imagePath != null) {
        return await convertImageToBase64(File(imagePath));
      }
      return '';
    }

    final base64DataTouristAttraction =
        await getBase64Data(imagePathTouristAttraction);
    final base64DataAvatarHistory = await getBase64Data(imagePathAvatarHistory);
    final base64DataimgHistory = await getBase64Data(imagePathimgHistory);
    final base64DataimgCulture = await getBase64Data(imagePathimgCulture);
    final base64DataimgDish = await getBase64Data(imagePathimgDish);

    updateImageBloc.add(
      AddTouristAttractionButtonPressed(
        idRegion: 'MN',
        idProvines: '53',
        nameTourist: nameTourist,
        typeTourist: typeTourist,
        address: address,
        ticket: ticket,
        imgTourist: base64DataTouristAttraction,
        touristIntroduction: touristIntroduction,
        rightTime: rightTime,
        titleStoryStory: titleStoryStory,
        contentStoryStory: contentStoryStory,
        avatarHistory: base64DataAvatarHistory,
        imgHistory: base64DataimgHistory,
        videoHistory: '',
        titleCulture: titleCulture,
        contentCulture: contentCulture,
        imgCulture: base64DataimgCulture,
        videoCulture: '',
        nameDish: nameDish,
        addressDish: addressDish,
        imgDish: base64DataimgDish,
        dishIntroduction: dishIntroduction,
        comment: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                onChanged: (value) {
                  setState(
                    () {
                      nameTourist = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      typeTourist = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      address = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      ticket = value;
                    },
                  );
                },
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
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  isCheckUploadImgTouristAttraction =
                      !isCheckUploadImgTouristAttraction;
                });
              },
              child: isCheckUploadImgTouristAttraction
                  ? Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          image: isCheckUploadImgTouristAttraction &&
                                  imagePathTouristAttraction != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      File(imagePathTouristAttraction!)),
                                )
                              : null,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage(_imagePickerTouristAttraction, 'imgTourist');
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
                          size: 30,
                          color: Colors.black,
                        ),
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
                onChanged: (value) {
                  setState(
                    () {
                      touristIntroduction = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      rightTime = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      titleStoryStory = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      contentStoryStory = value;
                    },
                  );
                },
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
            GestureDetector(
              onTap: () {
                setState(() {
                  isCheckUploadImgAvatarHistory =
                      !isCheckUploadImgAvatarHistory;
                });
              },
              child: isCheckUploadImgAvatarHistory
                  ? Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          image: isCheckUploadImgAvatarHistory &&
                                  imagePathAvatarHistory != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      FileImage(File(imagePathAvatarHistory!)),
                                )
                              : null,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage(_imagePickerAvatarHistory, 'avatarHistory');
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
                          size: 30,
                          color: Colors.black,
                        ),
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
            GestureDetector(
              onTap: () {
                setState(() {
                  isCheckUploadImgimgHistory = !isCheckUploadImgimgHistory;
                });
              },
              child: isCheckUploadImgimgHistory
                  ? Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          image: isCheckUploadImgimgHistory &&
                                  imagePathimgHistory != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(imagePathimgHistory!)),
                                )
                              : null,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage(_imagePickerimgHistory, 'imgHistory');
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
                          size: 30,
                          color: Colors.black,
                        ),
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
                onChanged: (value) {
                  setState(
                    () {
                      titleCulture = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      contentCulture = value;
                    },
                  );
                },
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
            GestureDetector(
              onTap: () {
                setState(() {
                  isCheckUploadImgimgCulture = !isCheckUploadImgimgCulture;
                });
              },
              child: isCheckUploadImgimgCulture
                  ? Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          image: isCheckUploadImgimgCulture &&
                                  imagePathimgCulture != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(imagePathimgCulture!)),
                                )
                              : null,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage(_imagePickerimgCulture, 'imgCulture');
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
                          size: 30,
                          color: Colors.black,
                        ),
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
                onChanged: (value) {
                  setState(
                    () {
                      nameDish = value;
                    },
                  );
                },
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
                onChanged: (value) {
                  setState(
                    () {
                      addressDish = value;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            const Text(
              'Hình ảnh cho món ăn(nếu có)',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  isCheckUploadImgimgDish = !isCheckUploadImgimgDish;
                });
              },
              child: isCheckUploadImgimgDish
                  ? Center(
                      child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          image: isCheckUploadImgimgDish &&
                                  imagePathimgDish != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(imagePathimgDish!)),
                                )
                              : null,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _pickImage(_imagePickerimgDish, 'imgDish');
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
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
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
                onChanged: (value) {
                  setState(
                    () {
                      dishIntroduction = value;
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  createTouristAttraction();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Thêm địa điểm mới',
                    style: TextStyle(
                      fontSize: 20,
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
