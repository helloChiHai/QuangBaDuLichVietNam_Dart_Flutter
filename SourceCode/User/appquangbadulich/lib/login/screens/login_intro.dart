import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class LoginIntro extends StatefulWidget {
  const LoginIntro({super.key});

  @override
  State<LoginIntro> createState() => _LoginIntroState();
}

class _LoginIntroState extends State<LoginIntro> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      home: IntroductionScreen(
        pages: [
          buildIntroPage("assets/img/img_4.png", "Page 1", "This is page 1"),
          buildIntroPage("assets/img/img_5.png", "Page 2", "This is page 2"),
          buildIntroPage("assets/img/img_6.png", "Page 3", "This is page 3"),
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
            "Skip",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        done: const Text(
          "Done",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        showNextButton: false,
      ),
    );
  }

  PageViewModel buildIntroPage(String imagePath, String title, String body) {
    return PageViewModel(
      title: title,
      body: body,
      image: Stack(
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: Text(
              body,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}