import 'package:flutter/material.dart';

class DetailContent extends StatefulWidget {
  const DetailContent({super.key});

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hồ Hoàn Kiếm (chữ Nôm: 湖還劍 hoặc 還劍湖) còn được gọi là Hồ Gươm là một hồ nước ngọt tự nhiên nằm ở trung tâm thành phố Hà Nội. Hồ có diện tích khoảng 12 ha[2]. Trước kia, hồ còn có các tên gọi là hồ Lục Thủy (vì nước có màu xanh quanh năm), hồ Thủy Quân (dùng để duyệt thủy binh), hồ Tả Vọng và Hữu Vọng (trong thời Lê mạt). Tên gọi Hoàn Kiếm xuất hiện vào đầu thế kỷ 15 gắn với truyền thuyết vua Lê Lợi trả lại gươm thần cho Rùa thần. Theo truyền thuyết, trong một lần vua Lê Thái Tổ dạo chơi trên thuyền, bỗng một con rùa vàng nổi lên mặt nước đòi nhà vua trả thanh gươm mà Long Vương cho mượn để đánh đuổi quân Minh xâm lược. Nhà vua liền trả gươm cho rùa thần và rùa lặn xuống nước biến mất. Từ đó hồ được lấy tên là hồ Hoàn Kiếm. Tên hồ còn được lấy để đặt cho một quận trung tâm của Hà Nội (quận Hoàn Kiếm) và là hồ nước duy nhất của quận này cho đến ngày nay.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Lịch sử',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
