import 'package:adminquangbadulich/addTouristAttraction/screens/addTouristAttraction_page.dart';
import 'package:adminquangbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';
import 'package:adminquangbadulich/province/bloc/province_bloc.dart';
import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:adminquangbadulich/showFilterAllTourist/screens/showAllTouristAttraction_page.dart';
import 'package:adminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_bloc.dart';
import 'package:adminquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'addTouristAttraction/bloc/addTouristAttraction_bloc.dart';
import 'comment/bloc/comment_bloc.dart';
import 'detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_bloc.dart';
import 'detailTouristAttraction/bloc/bloc_history/detailTourist_history_bloc.dart';
import 'detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_bloc.dart';
import 'detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'homeAdmin/screens/homeAdmin_page.dart';
import 'loginAdmin/bloc/loginAdmin_bloc.dart';
import 'loginAdmin/screens/loginAdmin_page.dart';
import 'searchTouristAttraction/srceens/searchTouristAttraction_page.dart';
import 'showFilterAllTourist/bloc/filterTourist_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/addTouristAttraction': (context) => AddTouristAttractionPage(),
        '/searchTouristAttraction': (context) => SearchTouristAttractionPage(),
        '/showAllTouristAttraction': (context) => ShowAllTouristAttraction(),
        '/detail_touriestAttraction_about': (context) =>
            DetailTouristAttraction_AboutPage(),
        '/homeAdmin': (context) => HomeAdminPage(),
        '/loginAdmin': (context) => LoginAdminPage(),
      },
      home: HomeAdminPage(),
    );
  }
}

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AddTouristAttractionBloc>(
        create: (context) => AddTouristAttractionBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<ProvinceBloc>(
        create: (context) => ProvinceBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<FilterTouristBloc>(
        create: (context) => FilterTouristBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<TotalTouristAttractionBloc>(
        create: (context) => TotalTouristAttractionBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<TouristAttractionBloc>(
        create: (context) => TouristAttractionBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<DetailTourist_AboutBloc>(
        create: (context) => DetailTourist_AboutBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<DetailTourist_SpecialDishBloc>(
        create: (context) => DetailTourist_SpecialDishBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<DetailTourist_HistoryBloc>(
        create: (context) => DetailTourist_HistoryBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<DetailTourist_CultureBloc>(
        create: (context) => DetailTourist_CultureBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<CommentBloc>(
        create: (context) => CommentBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<LoginAdminBloc>(
        create: (context) => LoginAdminBloc(
          adminRepository: AdminRepository(),
        ),
      ),
    ],
    child: MyApp(),
  ));
}
