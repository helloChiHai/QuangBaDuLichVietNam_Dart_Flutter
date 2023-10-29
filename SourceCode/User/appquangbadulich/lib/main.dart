import 'package:appquangbadulich/detailTouristAttraction/screens/detail_touristacctraction.dart';
import 'package:appquangbadulich/login/bloc/login_bloc.dart';
import 'package:appquangbadulich/login/screens/login_intro.dart';
import 'package:appquangbadulich/createAccount/screens/login_signUpSuccesful.dart';
import 'package:appquangbadulich/region/bloc/region_bloc.dart';
import 'package:appquangbadulich/region/screens/region_page.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'createAccount/bloc/createAccount_bloc.dart';
import 'createAccount/screens/createAccont_page.dart';
import 'detailTouristAttraction/screens/detailTourist_comment.dart';
import 'detailTouristAttraction/screens/detailTourist_content.dart';
import 'detailTouristAttraction/screens/detailTourist_culture.dart';
import 'detailTouristAttraction/screens/detailTourist_history.dart';
import 'detailTouristAttraction/screens/detailTourist_specialtyDish.dart';
import 'home/screens/home_page.dart';
import 'login/screens/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/createAccount': (context) => CreateAccountPage(),
        '/regions': (context) => RegionPage(),
        '/intro_login': (context) => LoginIntro(),
        '/createAccountSuccesful': (context) => CreateAccountSuccessful(),
        '/home': (context) => HomePage(),
        '/detail_touriestAttraction': (context) => DetailTouristAttraction(),
        '/detail_content': (context) => DetailContent(),
        '/detail_comment': (context) => CommentTourist(),
        '/detail_culture': (context) => DetailCulture(),
        '/detail_history': (context) => DetailHistory(),
        '/detail_specialtyDish': (context) => DetailSpecialtyDish(),
      },
      home: DetailTouristAttraction(), 
    );
  }
}

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<CreateAccountBloc>(
          create: (context) => CreateAccountBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<RegionBloc>(
          create: (context) => RegionBloc(
            userRepository: UserRepository(),
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}