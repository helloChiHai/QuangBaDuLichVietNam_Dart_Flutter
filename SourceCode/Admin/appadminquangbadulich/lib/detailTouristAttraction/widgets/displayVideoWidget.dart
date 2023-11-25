import 'package:appadminquangbadulich/detailTouristAttraction/widgets/playVideo_widget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final String youtubeVideoUrl;

  YouTubePlayerWidget({required this.youtubeVideoUrl});

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late String youtubeVideoUrl;
  @override
  void initState() {
    super.initState();
    youtubeVideoUrl = widget.youtubeVideoUrl;
  }

  bool isAsset(String url) {
    return url.endsWith('.mp4');
  }

  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayer.convertUrlToId(youtubeVideoUrl);
    return Center(
      child: isAsset(youtubeVideoUrl)
          ? PlayVideoWidget(videoPath: 'assets/img/$youtubeVideoUrl')
          : videoId != null
              ? YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId:
                        YoutubePlayer.convertUrlToId(youtubeVideoUrl) ?? '',
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 50,
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.tv_rounded,
                        size: 100,
                      ),
                      Text(
                        'Video không tìm thấy trên YouTube',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
