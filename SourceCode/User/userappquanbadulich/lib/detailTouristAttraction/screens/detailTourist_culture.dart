import 'package:flutter/material.dart';
import 'package:userappquanbadulich/model/cultureModel.dart';
import 'package:video_player/video_player.dart';

class DetailCulture extends StatefulWidget {
  final List<CultureModel> dataCulture;
  const DetailCulture({Key? key, required this.dataCulture}) : super(key: key);

  @override
  State<DetailCulture> createState() => _DetailCultureState();
}

class _DetailCultureState extends State<DetailCulture> {
  late VideoPlayerController _controller;
  late List<CultureModel> cultures;

  @override
  void initState() {
    super.initState();
    cultures = widget.dataCulture;
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
        itemCount: cultures.length,
        itemBuilder: (context, index) {
          final culture = cultures[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                culture.titleCulture,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                culture.contentCulture,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
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
