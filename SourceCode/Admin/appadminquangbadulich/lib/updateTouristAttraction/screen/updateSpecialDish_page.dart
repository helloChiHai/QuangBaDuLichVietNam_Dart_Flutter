import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:appadminquangbadulich/update_tourist_specialDish/bloc/update_tourist_specialDish_event.dart';
import 'package:appadminquangbadulich/update_tourist_specialDish/bloc/update_tourist_specialDish_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/specialtyDishModel.dart';
import '../../update_tourist_specialDish/bloc/update_tourist_specialDish_bloc.dart';

class UpdateSpecialtyDishPage extends StatefulWidget {
  final List<SpecialtyDishModel> dataSpecialtyDish;
  final String idTourist;
  const UpdateSpecialtyDishPage({
    Key? key,
    required this.dataSpecialtyDish,
    required this.idTourist,
  }) : super(key: key);

  @override
  State<UpdateSpecialtyDishPage> createState() =>
      _UpdateSpecialtyDishPageState();
}

class _UpdateSpecialtyDishPageState extends State<UpdateSpecialtyDishPage> {
  late List<SpecialtyDishModel> specialDishs;
  late String idTourist;

  bool isCheckUploadImgTouristAttraction = false;
  List<String?> updatedImagePaths = [];
  final ImagePicker _imagePickerImgTourist = ImagePicker();

  List<TextEditingController?> listNameDishController = [];
  List<TextEditingController?> listAddressDishController = [];
  List<TextEditingController?> listDishIntroductionController = [];

  @override
  void initState() {
    super.initState();
    specialDishs = widget.dataSpecialtyDish;
    idTourist = widget.idTourist;

    listNameDishController =
        List.generate(specialDishs.length, (index) => TextEditingController());

    listAddressDishController =
        List.generate(specialDishs.length, (index) => TextEditingController());
    listDishIntroductionController =
        List.generate(specialDishs.length, (index) => TextEditingController());

    updatedImagePaths = List.generate(specialDishs.length, (index) => null);

    for (int i = 0; i < specialDishs.length; i++) {
      listNameDishController[i]!.text = specialDishs[i].nameDish;
    }

    for (int i = 0; i < specialDishs.length; i++) {
      listAddressDishController[i]!.text = specialDishs[i].addressDish;
    }
    for (int i = 0; i < specialDishs.length; i++) {
      listDishIntroductionController[i]!.text =
          specialDishs[i].dishIntroduction;
    }
  }

  void _updateSpecialDish(int index) async {
    Future<String> getBase64Data(String? imagePath, String imgDefault) async {
      if (imagePath != null) {
        return await convertImageToBase64(File(imagePath));
      }
      return imgDefault;
    }

    String imgHistory = await getBase64Data(
        updatedImagePaths[index], specialDishs[index].imgDish!);

    BlocProvider.of<UpdateTouristSpeicalDishBloc>(context).add(
      UpdateTouristSpecialDishButtonPressed(
        idTourist: idTourist,
        idDish: specialDishs[index].idDish,
        nameDish: listNameDishController[index]!.text,
        addressDish: listAddressDishController[index]!.text,
        imgDish: imgHistory,
        dishIntroduction: listDishIntroductionController[index]!.text,
      ),
    );
  }

  Future<void> _pickImage(
      ImagePicker imagePicker, String type, int index) async {
    final PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (type == 'imgDish') {
        setState(() {
          isCheckUploadImgTouristAttraction = true;
          updatedImagePaths[index] = pickedFile.path;
        });
      }
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<Widget> _buildImage(String? img, int index) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return SizedBox(
          height: 250,
          child: Image.memory(
            Uint8List.fromList(imageBytes),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      } catch (e) {
        return SizedBox(
          height: 250,
          child: Image.asset(
            'assets/img/$img',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }
    } else {
      return const SizedBox();
    }
  }

  void handleTextChange(
      String newText, TextEditingController controller, String initialValue) {
    setState(() {
      if (newText.isEmpty) {
        controller.text = initialValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: specialDishs.length,
        itemBuilder: (context, index) {
          final specialtyDish = specialDishs[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<UpdateTouristSpeicalDishBloc,
                      UpdateTouristSpecialDishState>(
                    listener: (context, state) {
                      if (state is UpdateTouristSpecialDishSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Cập nhật món ăn thành công!',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is UpdateTouristSpecialDishFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Cập nhật món ăn không thành công!',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: GestureDetector(
                      onTap: () {
                        _updateSpecialDish(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[200],
                        ),
                        child: const Text(
                          'Cập nhật món ăn',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 10),
              specialtyDish.nameDish.isEmpty
                  ? TextField(
                      controller: listNameDishController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listNameDishController[index]!,
                          specialtyDish.nameDish),
                      decoration: InputDecoration(
                        hintText: specialtyDish.nameDish,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: null,
                    )
                  : TextField(
                      controller: listNameDishController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listNameDishController[index]!,
                          specialtyDish.nameDish),
                      decoration: InputDecoration(
                        hintText: specialtyDish.nameDish,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              const SizedBox(height: 5),
              const Text(
                'Địa chỉ: ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              specialtyDish.addressDish.isEmpty
                  ? TextField(
                      controller: listAddressDishController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listAddressDishController[index]!,
                          specialtyDish.addressDish),
                      decoration: InputDecoration(
                        hintText: specialtyDish.addressDish,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: null,
                    )
                  : TextField(
                      controller: listAddressDishController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listAddressDishController[index]!,
                          specialtyDish.addressDish),
                      decoration: InputDecoration(
                        hintText: specialtyDish.addressDish,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     const SizedBox(height: 10),
              TextField(
                controller: listDishIntroductionController[index],
                onChanged: (text) => handleTextChange(
                    text,
                    listDishIntroductionController[index]!,
                    specialtyDish.dishIntroduction),
                decoration: InputDecoration(
                  hintText: specialtyDish.dishIntroduction,
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
                maxLines: null,
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 250,
                color: const Color.fromARGB(255, 173, 207, 235),
                child: Stack(
                  children: [
                    updatedImagePaths[index] == null
                        ? FutureBuilder<Widget>(
                            future: _buildImage(
                                specialtyDish.imgDish, index),
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
                              image: isCheckUploadImgTouristAttraction &&
                                      updatedImagePaths[index] != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(updatedImagePaths[index]!)),
                                    )
                                  : null,
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
                          _pickImage(_imagePickerImgTourist, 'imgDish', index);
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
              const SizedBox(height: 30),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}
