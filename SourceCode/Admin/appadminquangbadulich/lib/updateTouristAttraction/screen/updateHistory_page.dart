import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:appadminquangbadulich/detailTouristAttraction/widgets/displayVideoWidget.dart';
import 'package:appadminquangbadulich/update_tourist_history/bloc/update_tourist_history_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/historyModel.dart';
import '../../update_tourist_history/bloc/update_tourist_history_bloc.dart';
import '../../update_tourist_history/bloc/update_tourist_history_state.dart';

class UpdateHistoryPage extends StatefulWidget {
  final List<HistoryModel> dataHistory;
  final String idTourist;

  const UpdateHistoryPage({
    Key? key,
    required this.dataHistory,
    required this.idTourist,
  }) : super(key: key);

  @override
  State<UpdateHistoryPage> createState() => _UpdateHistoryPageState();
}

class _UpdateHistoryPageState extends State<UpdateHistoryPage> {
  late List<HistoryModel> histories;
  late String idTourist;

  bool isCheckUploadImgTouristAttraction = false;
  List<String?> updatedImagePaths = [];
  final ImagePicker _imagePickerImgTourist = ImagePicker();

  List<TextEditingController?> listTitleStoryController = [];
  List<TextEditingController?> listcontentStoryController = [];

  @override
  void initState() {
    super.initState();
    histories = widget.dataHistory;
    idTourist = widget.idTourist;

    listTitleStoryController =
        List.generate(histories.length, (index) => TextEditingController());

    listcontentStoryController =
        List.generate(histories.length, (index) => TextEditingController());

    updatedImagePaths = List.generate(histories.length, (index) => null);

    for (int i = 0; i < histories.length; i++) {
      listTitleStoryController[i]!.text = histories[i].titleStoryStory;
    }

    for (int i = 0; i < histories.length; i++) {
      listcontentStoryController[i]!.text = histories[i].contentStoryStory;
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void _updateHistory(int index) async {
    Future<String> getBase64Data(String? imagePath, String imgDefault) async {
      if (imagePath != null) {
        return await convertImageToBase64(File(imagePath));
      }
      return imgDefault;
    }

    String imgHistory = await getBase64Data(
        updatedImagePaths[index], histories[index].imgHistory!);

    BlocProvider.of<UpdateTouristHistoryBloc>(context).add(
      UpdateTouristHistoryButtonPressed(
        idTourist: idTourist,
        idHistoryStory: histories[index].idHistoryStory,
        titleStoryStory: listTitleStoryController[index]!.text,
        contentStoryStory: listcontentStoryController[index]!.text,
        imgHistory: imgHistory,
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
        itemCount: histories.length,
        itemBuilder: (context, index) {
          final history = histories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocListener<UpdateTouristHistoryBloc,
                      UpdateTouristHistoryState>(
                    listener: (context, state) {
                      if (state is UpdateTouristHistorySuccess) {
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
                      } else if (state is UpdateTouristHistoryFailure) {
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
                          'Cập nhật lịch sử',
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
                      print(history.idHistoryStory);
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
                        'Xóa lịch sử',
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
              history.titleStoryStory.isEmpty
                  ? TextField(
                      controller: listTitleStoryController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listTitleStoryController[index]!,
                          history.titleStoryStory),
                      decoration: InputDecoration(
                        hintText: history.titleStoryStory,
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
                      controller: listTitleStoryController[index],
                      onChanged: (text) => handleTextChange(
                          text,
                          listTitleStoryController[index]!,
                          history.titleStoryStory),
                      decoration: InputDecoration(
                        hintText: history.titleStoryStory,
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
                controller: listcontentStoryController[index],
                onChanged: (text) => handleTextChange(
                    text,
                    listcontentStoryController[index]!,
                    history.contentStoryStory),
                decoration: InputDecoration(
                  hintText: history.contentStoryStory,
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
                            future: _buildImage(history.imgHistory, index),
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
              if (history.videoHistory != null &&
                  history.videoHistory!.isNotEmpty)
                YouTubePlayerWidget(
                  youtubeVideoUrl: history.videoHistory!,
                )
              else
                Container(),
              const Divider(
                color: Colors.black,
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
