import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class DetailCulture extends StatefulWidget {
  const DetailCulture({super.key});

  @override
  State<DetailCulture> createState() => _DetailCultureState();
}

class _DetailCultureState extends State<DetailCulture> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
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
      child: Column(
        children: [
          const Text(
            'Hồ Hoàn Kiếm (chữ Nôm: 湖還劍 hoặc 還劍湖) còn được gọi là Hồ Gươm là một hồ nước ngọt tự nhiên nằm ở trung tâm thành phố Hà Nội. Hồ có diện tích khoảng 12 ha[2]. Trước kia, hồ còn có các tên gọi là hồ Lục Thủy (vì nước có màu xanh quanh năm), hồ Thủy Quân (dùng để duyệt thủy binh), hồ Tả Vọng và Hữu Vọng (trong thời Lê mạt). Tên gọi Hoàn Kiếm xuất hiện vào đầu thế kỷ 15 gắn với truyền thuyết vua Lê Lợi trả lại gươm thần cho Rùa thần. Theo truyền thuyết, trong một lần vua Lê Thái Tổ dạo chơi trên thuyền, bỗng một con rùa vàng nổi lên mặt nước đòi nhà vua trả thanh gươm mà Long Vương cho mượn để đánh đuổi quân Minh xâm lược. Nhà vua liền trả gươm cho rùa thần và rùa lặn xuống nước biến mất. Từ đó hồ được lấy tên là hồ Hoàn Kiếm. Tên hồ còn được lấy để đặt cho một quận trung tâm của Hà Nội (quận Hoàn Kiếm) và là hồ nước duy nhất của quận này cho đến ngày nay.',
            style: TextStyle(
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
