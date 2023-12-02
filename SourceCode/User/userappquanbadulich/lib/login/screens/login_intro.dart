import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginIntro extends StatefulWidget {
  const LoginIntro({Key? key}) : super(key: key);

  @override
  State<LoginIntro> createState() => _LoginIntroState();
}

class _LoginIntroState extends State<LoginIntro> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroductionScreen(
        pages: [
          buildIntroPage("assets/img/img_intro_1.png", "VietWander",
              "Với ứng dụng du lịch, hòa mình vào văn hóa phong phú và thưởng thức cảnh đẹp độc đáo của Việt Nam!"),
          buildIntroPage("assets/img/img_intro_2.png", "Việt Nam Đẹp Mê Hồn",
              "Đặt chân vào thế giới du lịch Việt Nam qua ứng dụng VietWander, khám phá văn hóa, ẩm thực và phong cảnh tuyệt vời, đầy ấn tượng!"),
          buildIntroPage(
              "assets/img/img_intro_3.png",
              "Việt Nam: Cuộc Phiêu Lưu Hấp Dẫn",
              "Khám phá hành trình đẳng cấp, từ văn hóa đến cảnh đẹp, với ứng dụng du lịch độc quyền. Hãy sẵn sàng cho cuộc phiêu lưu tuyệt vời!"),
        ],
        onDone: () {
          Navigator.of(context).pushNamed('/login');
        },
        showSkipButton: true,
        skip: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "Bỏ qua",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        done: const Text(
          "Khám phá",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        showNextButton: false,
      ),
    );
    
  }

  PageViewModel buildIntroPage(String imagePath, String title, String body) {
    return PageViewModel(
      titleWidget: SizedBox(
        height: 70,
        child: TyperAnimatedTextKit(
          speed: Duration(milliseconds: 50),
          isRepeatingAnimation: false,
          text: [title],
          textStyle: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      bodyWidget: SizedBox(
        height: 100,
        child: TyperAnimatedTextKit(
          speed: Duration(milliseconds: 50),
          isRepeatingAnimation: false,
          text: [body],
          textStyle: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      image: Image.asset(
        imagePath,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}
