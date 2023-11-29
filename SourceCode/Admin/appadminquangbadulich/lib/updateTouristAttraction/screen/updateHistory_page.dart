import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/detailTouristAttraction/widgets/displayVideoWidget.dart';
import 'package:flutter/material.dart';

import '../../model/historyModel.dart';

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
  late List<HistoryModel> hitories;
  late String idTourist;
  TextEditingController titleStoryStoryController = TextEditingController();
  TextEditingController contentStoryStoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hitories = widget.dataHistory;
    idTourist = widget.idTourist;
  }

  Future<Widget> _buildImage(String? img) async {
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
        itemCount: hitories.length,
        itemBuilder: (context, index) {
          final history = hitories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      print(history.idHistoryStory);
                      print(idTourist);
                      print(titleStoryStoryController.text);
                      print(contentStoryStoryController.text);
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
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      print(history.idHistoryStory);
                      print(idTourist);
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
                      controller: titleStoryStoryController,
                      onChanged: (text) => handleTextChange(text,
                          titleStoryStoryController, history.titleStoryStory),
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
                      maxLines: 1,
                    )
                  : TextField(
                      controller: titleStoryStoryController,
                      onChanged: (text) => handleTextChange(text,
                          titleStoryStoryController, history.titleStoryStory),
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
                controller: contentStoryStoryController,
                onChanged: (text) => handleTextChange(text,
                    contentStoryStoryController, history.contentStoryStory),
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
              FutureBuilder<Widget>(
                future: _buildImage(history.imgHistory),
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.data ?? Container();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
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
