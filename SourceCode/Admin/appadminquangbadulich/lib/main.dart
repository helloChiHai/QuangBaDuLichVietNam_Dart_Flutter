import 'package:appadminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/addTouristAttraction/screens/addTouristAttraction_page.dart';
import 'package:appadminquangbadulich/comment/bloc/comment_bloc.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';
import 'package:appadminquangbadulich/homeAdmin/screens/homeAdmin_page.dart';
import 'package:appadminquangbadulich/loginAdmin/bloc/loginAdmin_bloc.dart';
import 'package:appadminquangbadulich/loginAdmin/screens/loginAdmin_page.dart';
import 'package:appadminquangbadulich/province/bloc/province_bloc.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/searchTouristAttraction/srceens/searchTouristAttraction_page.dart';
import 'package:appadminquangbadulich/showFilterAllTourist/bloc/filterTourist_bloc.dart';
import 'package:appadminquangbadulich/showFilterAllTourist/screens/showAllTouristAttraction_page.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/searchTouristAttraction': (context) => SearchTouristAttractionPage(),
        '/addTouristAttraction': (context) => AddTouristAttractionPage(),
        '/showAllTouristAttraction': (context) => ShowAllTouristAttraction(),
        '/detail_touriestAttraction_about': (context) =>
            DetailTouristAttraction_AboutPage(),
        '/homeAdmin': (context) => HomeAdminPage(),
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
      BlocProvider<FilterTouristBloc>(
        create: (context) => FilterTouristBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<ProvinceBloc>(
        create: (context) => ProvinceBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<CommentBloc>(
        create: (context) => CommentBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<DetailTourist_AboutBloc>(
        create: (context) => DetailTourist_AboutBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<TouristAttractionBloc>(
        create: (context) => TouristAttractionBloc(
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
