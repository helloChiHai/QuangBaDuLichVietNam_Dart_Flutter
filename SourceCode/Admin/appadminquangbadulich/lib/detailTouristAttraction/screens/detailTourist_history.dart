import 'package:flutter/material.dart';

import '../../model/historyModel.dart';
import '../widgets/playVideo_widget.dart';

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
              Text(
                history.contentStoryStory,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              history.imgHistory!.isEmpty
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      height: 250,
                      child: Image.asset(
                        'assets/img/${history.imgHistory}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 15),
              if (history.videoHistory != null &&
                  history.videoHistory!.isNotEmpty)
                PlayVideoWidget(videoPath: 'assets/img/${history.videoHistory}')
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
