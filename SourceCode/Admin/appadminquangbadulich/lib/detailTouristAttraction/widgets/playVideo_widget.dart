import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoWidget extends StatefulWidget {
  final String videoPath;

  const PlayVideoWidget({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<PlayVideoWidget> createState() => _PlayVideoWidgetState();
}

class _PlayVideoWidgetState extends State<PlayVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath);
      // ..initialize().then((_) {
      //   setState(() {});
      // });
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
    final newPosition = _controller.value.position - const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _seekForward() {
    final newPosition = _controller.value.position + const Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: _playVideo,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
