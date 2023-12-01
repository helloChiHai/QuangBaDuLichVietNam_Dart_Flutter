import 'package:appadminquangbadulich/addTouristAttraction/bloc/addTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/addTouristAttraction/screens/addTouristAttraction_page.dart';
import 'package:appadminquangbadulich/comment/bloc/comment_bloc.dart';
import 'package:appadminquangbadulich/deleteTouristAttraction/bloc/deleteTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/detailCustomer/screens/detailCustomer_page.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';
import 'package:appadminquangbadulich/homeAdmin/screens/homeAdmin_page.dart';
import 'package:appadminquangbadulich/listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_bloc.dart';
import 'package:appadminquangbadulich/loginAdmin/bloc/loginAdmin_bloc.dart';
import 'package:appadminquangbadulich/loginAdmin/screens/loginAdmin_page.dart';
import 'package:appadminquangbadulich/managerUser/bloc/userManagement_bloc.dart';
import 'package:appadminquangbadulich/managerUser/screen/managerUser_page.dart';
import 'package:appadminquangbadulich/province/bloc/province_bloc.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/searchTouristAttraction/srceens/searchTouristAttraction_page.dart';
import 'package:appadminquangbadulich/showFilterAllTourist/bloc/filterTourist_bloc.dart';
import 'package:appadminquangbadulich/showFilterAllTourist/screens/showAllTouristAttraction_page.dart';
import 'package:appadminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_bloc.dart';
import 'package:appadminquangbadulich/totalUser/bloc/totalUser_bloc.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:appadminquangbadulich/updateTouristAttraction/screen/updateTouristAttraction_page.dart';
import 'package:appadminquangbadulich/update_tourist_culture/bloc/update_tourist_culture_bloc.dart';
import 'package:appadminquangbadulich/update_tourist_history/bloc/update_tourist_history_bloc.dart';
import 'package:appadminquangbadulich/update_tourist_intro/bloc/update_tourist_intro_bloc.dart';
import 'package:appadminquangbadulich/update_tourist_specialDish/bloc/update_tourist_specialDish_bloc.dart';
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
        '/detailCustomer': (context) => DetailCustomerPage(),
        '/managerUserPage': (context) => ManagerUserPage(),
        '/updateTouristAttractionPage': (context) =>
            UpdateTouristAttrractionpage(),
        '/searchTouristAttraction': (context) => SearchTouristAttractionPage(),
        '/addTouristAttraction': (context) => AddTouristAttractionPage(),
        '/showAllTouristAttraction': (context) => ShowAllTouristAttraction(),
        '/detail_touriestAttraction_about': (context) =>
            DetailTouristAttraction_AboutPage(idTourist: ''),
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
      BlocProvider<UpdateTouristSpeicalDishBloc>(
        create: (context) => UpdateTouristSpeicalDishBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<UpdateTouristCultureBloc>(
        create: (context) => UpdateTouristCultureBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<UpdateTouristHistoryBloc>(
        create: (context) => UpdateTouristHistoryBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<UpdateTouristIntroBloc>(
        create: (context) => UpdateTouristIntroBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<GetTouristInFavoriteListBloc>(
        create: (context) => GetTouristInFavoriteListBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<UserManagementBloc>(
        create: (context) => UserManagementBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<TotalUserBloc>(
        create: (context) => TotalUserBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<TotalTouristAttractionBloc>(
        create: (context) => TotalTouristAttractionBloc(
          adminRepository: AdminRepository(),
        ),
      ),
      BlocProvider<DeleteTouristAttractionBloc>(
        create: (context) => DeleteTouristAttractionBloc(
          adminRepository: AdminRepository(),
        ),
      ),
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
