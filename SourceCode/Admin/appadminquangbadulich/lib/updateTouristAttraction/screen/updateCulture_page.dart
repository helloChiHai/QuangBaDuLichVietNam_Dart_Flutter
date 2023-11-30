import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:appadminquangbadulich/detailTouristAttraction/widgets/displayVideoWidget.dart';
import 'package:appadminquangbadulich/model/cultureModel.dart';
import 'package:appadminquangbadulich/update_tourist_culture/bloc/update_tourist_culture_bloc.dart';
import 'package:appadminquangbadulich/update_tourist_culture/bloc/update_tourist_culture_event.dart';
import 'package:appadminquangbadulich/update_tourist_culture/bloc/update_tourist_culture_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCulturePage extends StatefulWidget {
  final List<CultureModel> dataCulture;
  final String idTourist;

  const UpdateCulturePage({
    Key? key,
    required this.dataCulture,
    required this.idTourist,
  }) : super(key: key);

  @override
  State<UpdateCulturePage> createState() => _UpdateCulturePageState();
}

class _UpdateCulturePageState extends State<UpdateCulturePage> {
  late List<CultureModel> cultures;
  late String idTourist;

  bool isCheckUploadImgTouristAttraction = false;
  List<String?> updatedImagePaths = [];
  final ImagePicker _imagePickerImgTourist = ImagePicker();

  List<TextEditingController?> listTitleCultureController = [];
  List<TextEditingController?> listContentCultureController = [];

  @override
  void initState() {
    super.initState();
    cultures = widget.dataCulture;
    idTourist = widget.idTourist;

    listTitleCultureController =
        List.generate(cultures.length, (index) => TextEditingController());

    listContentCultureController =
        List.generate(cultures.length, (index) => TextEditingController());

    updatedImagePaths = List.generate(cultures.length, (index) => null);

    for (int i = 0; i < cultures.length; i++) {
      listTitleCultureController[i]!.text = cultures[i].titleCulture;
    }

    for (int i = 0; i < cultures.length; i++) {
      listContentCultureController[i]!.text = cultures[i].contentCulture;
    }
  }

  void _updateHistory(int index) async {
    Future<String> getBase64Data(String? imagePath, String imgDefault) async {
      if (imagePath != null) {
        return await convertImageToBase64(File(imagePath));
      }
      return imgDefault;
    }

    String imgHistory = await getBase64Data(
        updatedImagePaths[index], cultures[index].imgCulture!);

    BlocProvider.of<UpdateTouristCultureBloc>(context).add(
      UpdateTouristCultureButtonPressed(
        idTourist: idTourist,
        idCulture: cultures[index].idCulture,
        titleCulture: listTitleCultureController[index]!.text,
        contentCulture: listContentCultureController[index]!.text,
        imgCulture: imgHistory,
      ),
    );
  }

  Future<void> _pickImage(
      ImagePicker imagePicker, String type, int index) async {
    final PickedFile? pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (type == 'imgHistory') {
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
        itemCount: cultures.length,
        itemBuilder: (context, index) {
          final culture = cultures[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocListener<UpdateTouristCultureBloc,
                      UpdateTouristCultureState>(
                    listener: (context, state) {
                      if (state is UpdateTouristCultureSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Cập nhật văn hóa thành công!',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else if (state is UpdateTouristCultureFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Cập nhật văn hóa không thành công!',
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
                        _updateHistory(index);
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
                          'Cập nhật văn hóa',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      print(culture.idCulture);
                      print(idTourist);
                      // Add any other delete logic you need here
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
                        'Xóa văn hóa',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              culture.titleCulture.isEmpty
                  ? TextField(
                      controller: listTitleCultureController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listTitleCultureController[index]!,
                          culture.titleCulture),
                      decoration: InputDecoration(
                        hintText: culture.titleCulture,
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
                      controller: listTitleCultureController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listTitleCultureController[index]!,
                          culture.titleCulture),
                      decoration: InputDecoration(
                        hintText: culture.titleCulture,
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
                controller: listContentCultureController[index],
                onChanged: (text) => handleTextChange(
                    text,
                    listContentCultureController[index]!,
                    culture.contentCulture),
                decoration: InputDecoration(
                  hintText: culture.contentCulture,
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
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 250,
                color: const Color.fromARGB(255, 173, 207, 235),
                child: Stack(
                  children: [
                    updatedImagePaths[index] == null
                        ? FutureBuilder<Widget>(
                            future: _buildImage(culture.imgCulture, index),
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
                          _pickImage(
                              _imagePickerImgTourist, 'imgHistory', index);
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
              const SizedBox(height: 15),
              if (culture.videoCulture != null &&
                  culture.videoCulture!.isNotEmpty)
                YouTubePlayerWidget(
                  youtubeVideoUrl: culture.videoCulture!,
                )
              else
                Container(),
            ],
          );
        },
      ),
    );
  }
}
