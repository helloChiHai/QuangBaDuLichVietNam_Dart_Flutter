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
    // TODO: implement initState
    super.initState();
    youtubeVideoUrl = widget.youtubeVideoUrl;
  }

  bool isAsset(String url) {
    // Kiểm tra xem đường dẫn có bắt đầu bằng "assets/" hay không
    RegExp regExp = RegExp(r'^video/');
    return regExp.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isAsset(youtubeVideoUrl)
          ? PlayVideoWidget(videoPath: 'assets/img/$youtubeVideoUrl')
          : YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId:
                    YoutubePlayer.convertUrlToId(youtubeVideoUrl) ?? '',
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: YouTubePlayerWidget(
//         youtubeVideoUrl: "assets/img/l;aksjdf",
//         // youtubeVideoUrl:
//         //     "https://www.youtube.com/watch?v=k1eBq9b3XMg&list=RDk1eBq9b3XMg&start_radio=1",
//       ),
//     );
//   }
// }
