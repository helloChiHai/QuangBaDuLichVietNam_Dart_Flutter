import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:appadminquangbadulich/comment/screens/comment_page.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_culture.dart';
import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:appadminquangbadulich/updateTouristAttraction/screen/updateDetailContent_page.dart';
import 'package:appadminquangbadulich/updateTouristAttraction/screen/updateHistory_page.dart';
import 'package:appadminquangbadulich/updateTouristAttraction/screen/updateSpecialDish_page.dart';
import 'package:appadminquangbadulich/update_tourist_intro/bloc/update_tourist_intro_bloc.dart';
import 'package:appadminquangbadulich/update_tourist_intro/bloc/update_tourist_intro_event.dart';
import 'package:appadminquangbadulich/update_tourist_intro/bloc/update_tourist_intro_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateTouristAttractionWidget extends StatefulWidget {
  final TouristAttractionModel tourist;

  const UpdateTouristAttractionWidget({
    Key? key,
    required this.tourist,
  }) : super(key: key);

  @override
  State<UpdateTouristAttractionWidget> createState() =>
      _UpdateTouristAttractionWidgetState();
}

class _UpdateTouristAttractionWidgetState
    extends State<UpdateTouristAttractionWidget> {
  late TouristAttractionModel tourist;
  PageController pageController = PageController();
  int pageViewInit = 0;
  TextEditingController nameTouristController = TextEditingController();
  TextEditingController addressTouristController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  TextEditingController rightTimeController = TextEditingController();
  TextEditingController typeTouristController = TextEditingController();
  TextEditingController touristIntroductionController = TextEditingController();
  // đặc sản
  TextEditingController nameDishController = TextEditingController();

  // upload hình ảnh tourist
  bool isCheckUploadImgTouristAttraction = false;
  String? imagePathTouristAttraction;
  final ImagePicker _imagePickerImgTourist = ImagePicker();

  @override
  void initState() {
    super.initState();
    tourist = widget.tourist;
    pageController = PageController(initialPage: pageViewInit);
    nameTouristController.text = tourist.nameTourist;
    addressTouristController.text = tourist.address;
    ticketController.text = tourist.ticket;
    rightTimeController.text = tourist.rightTime.join(', ');
    typeTouristController.text = tourist.typeTourist;
    touristIntroductionController.text = tourist.touristIntroduction;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void handleTextChange(
      String newText, TextEditingController controller, String initialValue) {
    setState(() {
      if (newText.isEmpty) {
        controller.text = initialValue;
      }
    });
  }

  void updateTextFieldValue(TextEditingController controller, String newValue) {
    setState(() {
      controller.text = newValue;
    });
  }

  Future<void> _pickImage(ImagePicker imagePicker, String type) async {
    final PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (type == 'imgTourist') {
        setState(() {
          isCheckUploadImgTouristAttraction = true;
          imagePathTouristAttraction = pickedFile.path;
        });
      }
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return Image.memory(
          Uint8List.fromList(imageBytes),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return Image.asset(
          'assets/img/$img',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      }
    } else {
      return Image.asset(
        'assets/img/img_12.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 310,
                color: const Color.fromARGB(255, 173, 207, 235),
                child: Stack(
                  children: [
                    imagePathTouristAttraction == null
                        ? FutureBuilder<Widget>(
                            future: _buildImage(tourist.imgTourist),
                            builder: (BuildContext context,
                                AsyncSnapshot<Widget> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return snapshot.data ?? Container();
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          )
                        : Container(
                            width: double.infinity,
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
                    BlocListener<UpdateTouristIntroBloc,
                        UpdateTouristIntroState>(
                      listener: (context, state) {
                        if (state is UpdateTouristIntroSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Cập nhật thành công!',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state is UpdateTouristIntroFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Cập nhật không thành công!',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 25,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            Future<String> getBase64Data(
                                String? imagePath, String imgDefault) async {
                              if (imagePath != null) {
                                return await convertImageToBase64(
                                    File(imagePath));
                              }
                              return imgDefault;
                            }

                            String img = await getBase64Data(
                                imagePathTouristAttraction,
                                tourist.imgTourist!);
                            // ignore: use_build_context_synchronously
                            BlocProvider.of<UpdateTouristIntroBloc>(context)
                                .add(UpdateTouristIntroButtonPressed(
                              idTourist: tourist.idTourist,
                              nameTourist: nameTouristController.text,
                              typeTourist: typeTouristController.text,
                              address: addressTouristController.text,
                              ticket: ticketController.text,
                              imgTourist: img,
                              touristIntroduction:
                                  touristIntroductionController.text,
                              rightTime: rightTimeController.text,
                            ));
                          },
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              margin: const EdgeInsets.only(
                                top: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cập nhật',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.check_circle_outline, size: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.05,
                      left: MediaQuery.of(context).size.width * 0.75,
                      top: 150,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isCheckUploadImgTouristAttraction =
                                !isCheckUploadImgTouristAttraction;
                          });
                          _pickImage(_imagePickerImgTourist, 'imgTourist');
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 290),
                padding: const EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                height: 3000,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: nameTouristController,
                            onChanged: (text) => handleTextChange(text,
                                nameTouristController, tourist.nameTourist),
                            decoration: InputDecoration(
                              hintText: tourist.nameTourist,
                              hintStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.place_outlined, size: 25),
                                Expanded(
                                  flex: 8,
                                  child: TextField(
                                    controller: addressTouristController,
                                    onChanged: (text) => handleTextChange(
                                        text,
                                        addressTouristController,
                                        tourist.address),
                                    decoration: InputDecoration(
                                      hintText: tourist.address,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.monetization_on_outlined,
                                    size: 25),
                                Expanded(
                                  flex: 8,
                                  child: TextField(
                                    controller: ticketController,
                                    onChanged: (text) => handleTextChange(
                                        text, ticketController, tourist.ticket),
                                    decoration: InputDecoration(
                                      hintText: tourist.ticket,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    size: 25),
                                const Text(
                                  'Thời điểm thích hợp: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  flex: 8,
                                  child: TextField(
                                    controller: rightTimeController,
                                    onChanged: (text) => handleTextChange(
                                        text,
                                        rightTimeController,
                                        tourist.rightTime.join(', ')),
                                    decoration: InputDecoration(
                                      hintText: tourist.rightTime.join(', '),
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.satellite, size: 25),
                                const Text(
                                  'Loại hình du lịch: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  flex: 8,
                                  child: TextField(
                                    controller: typeTouristController,
                                    onChanged: (text) => handleTextChange(
                                        text,
                                        typeTouristController,
                                        tourist.typeTourist),
                                    decoration: InputDecoration(
                                      hintText: tourist.typeTourist,
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Giới thiệu',
                                  style: TextStyle(
                                    color: pageViewInit == 0
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 0 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Văn hóa',
                                  style: TextStyle(
                                    color: pageViewInit == 1
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 1 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    2,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Lịch sử',
                                  style: TextStyle(
                                    color: pageViewInit == 2
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 2 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    3,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Đặc sản',
                                  style: TextStyle(
                                    color: pageViewInit == 3
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 3 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  pageController.animateToPage(
                                    4,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Text(
                                  'Bình luận',
                                  style: TextStyle(
                                    color: pageViewInit == 4
                                        ? Colors.black
                                        : const Color.fromARGB(255, 77, 76, 76),
                                    fontSize: pageViewInit == 4 ? 25 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            pageViewInit = index;
                          });
                        },
                        children: [
                          UpdateDetailContentPage(
                            touristIntroductionController:
                                touristIntroductionController,
                            onUpdate: (text) => updateTextFieldValue(
                                touristIntroductionController, text),
                            touristIntroduction: tourist.touristIntroduction,
                          ),
                          DetailCulture(dataCulture: tourist.culture),
                          UpdateHistoryPage(dataHistory: tourist.history, idTourist: tourist.idTourist),
                          UpdateSpecialtyDishPage(
                              dataSpecialtyDish: tourist.specialtyDish),
                          CommentPage(idTourist: tourist.idTourist),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
