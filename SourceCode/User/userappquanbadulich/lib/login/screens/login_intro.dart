import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

class LoginIntro extends StatefulWidget {
  const LoginIntro({Key? key}) : super(key: key);

  @override
  State<LoginIntro> createState() => _LoginIntroState();
}

class _LoginIntroState extends State<LoginIntro> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "VietWander",
        description:
            "Trải nghiệm cảm xúc độc đáo với đêm Hội Ánh Sáng Đà Nẵng, nơi ánh đèn kết hợp nghệ thuật tạo nên phố đi bộ sống động nhất",
        styleDescription: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        backgroundImage: "assets/img/img_1.jpg",
        backgroundFilterOpacity: 0.4,
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "VietWander",
        description:
            "Mê mải đắm chìm trong vẻ đẹp cổ kính của Lăng mộ Gia Long, hòa mình vào lịch sử huyền bí của đất nước Việt Nam",
        backgroundImage: "assets/img/img_3.jpg",
        styleDescription: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        backgroundFilterOpacity: 0.4,
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "VietWander",
        description:
            "Khám phá kỳ quan thiên nhiên hùng vĩ tại Hạ Long Bay, bức tranh tuyệt vời của Việt Nam",
        backgroundImage: "assets/img/img_2.jpg",
        styleDescription: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        backgroundFilterOpacity: 0.4,
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
      skipButtonStyle: ElevatedButton.styleFrom(
        primary: Colors.transparent, // Màu nền cho nút Skip
        textStyle: TextStyle(color: Colors.white), // Màu chữ cho nút Skip
      ),
      doneButtonStyle: ElevatedButton.styleFrom(
        primary: Colors.transparent, // Màu nền cho nút Done
        textStyle: TextStyle(color: Colors.white), // Màu chữ cho nút Done
      ),
      nextButtonStyle: ElevatedButton.styleFrom(
        primary: Colors.transparent, // Màu nền cho nút Next
        textStyle: TextStyle(color: Colors.white), // Màu chữ cho nút Next
      ),
    );
  }
}
