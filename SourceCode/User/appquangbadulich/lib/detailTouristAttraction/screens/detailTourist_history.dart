import 'package:appquangbadulich/region/model/historyModel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailHistory extends StatefulWidget {
  final List<HistoryModel> dataHistory;

  const DetailHistory({Key? key, required this.dataHistory}) : super(key: key);

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  late VideoPlayerController _controller;
  late List<HistoryModel> hitories;

  @override
  void initState() {
    super.initState();
    hitories = widget.dataHistory;
    _controller = VideoPlayerController.asset('assets/img/videoHistory_1.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void _playVideo() {
    if (_controller.value.isPlaying) {
      setState(() {
        _controller.pause();
      });
    } else {
      setState(() {
        _controller.play();
      });
    }
  }

  void _seekBackward() {
    final newPosition =
        _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _seekForward() {
    final newPosition =
        _controller.value.position + const Duration(seconds: 10);
    _controller.seekTo(newPosition);
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
              history.videoHistory!.isEmpty
                  ? const SizedBox()
                  : Container(
                      child: Column(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: _playVideo,
                              child: _controller.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    )
                                  : const CircularProgressIndicator(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.replay_10, size: 35),
                                onPressed: _seekBackward,
                              ),
                              IconButton(
                                icon: _controller.value.isPlaying
                                    ? const Icon(Icons.pause, size: 35)
                                    : const Icon(Icons.play_arrow, size: 35),
                                onPressed: _playVideo,
                              ),
                              IconButton(
                                icon: const Icon(Icons.forward_10, size: 35),
                                onPressed: _seekForward,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
