import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:userappquanbadulich/detailTouristAttraction/widgets/displayVideoWidget.dart';

import '../../model/historyModel.dart';

class DetailHistory extends StatefulWidget {
  final List<HistoryModel> dataHistory;

  const DetailHistory({Key? key, required this.dataHistory}) : super(key: key);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  late List<HistoryModel> hitories;

  @override
  void initState() {
    super.initState();
    hitories = widget.dataHistory;
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
            'assets/img/${img}',
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
              history.titleStoryStory.isEmpty
                  ? const SizedBox()
                  : Text(
                      history.titleStoryStory,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              const SizedBox(height: 10),
              Text(
                history.contentStoryStory,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
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
