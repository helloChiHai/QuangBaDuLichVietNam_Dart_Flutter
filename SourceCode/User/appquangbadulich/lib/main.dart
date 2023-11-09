import 'package:appquangbadulich/account/screens/account_page.dart';
import 'package:appquangbadulich/deleteAccount/bloc/deleteAccount_bloc.dart';
import 'package:appquangbadulich/deleteAccount/screens/deleteAccount_page.dart';
import 'package:appquangbadulich/account/screens/detailAccount_page.dart';
import 'package:appquangbadulich/updateAddress/bloc/updateAddress_bloc.dart';
import 'package:appquangbadulich/updateAddress/screens/updateAddress_page.dart';
import 'package:appquangbadulich/updateBirthday/bloc/updateBirthday_bloc.dart';
import 'package:appquangbadulich/updateBirthday/screens/updateBirthday_page.dart';
import 'package:appquangbadulich/updateEmail/bloc/updateEmail_bloc.dart';
import 'package:appquangbadulich/updateEmail/screens/updateEmail_page.dart';
import 'package:appquangbadulich/updatePassword.dart/bloc/updatePassword_bloc.dart';
import 'package:appquangbadulich/updatePassword.dart/screens/updatePassword_page.dart';
import 'package:appquangbadulich/culture/bloc/culture_bloc.dart';
import 'package:appquangbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_bloc.dart';
import 'package:appquangbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_bloc.dart';
import 'package:appquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_bloc.dart';
import 'package:appquangbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:appquangbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/detail_touristAttraction_about.dart';
import 'package:appquangbadulich/detailTouristAttraction/screens/detailTourist_culture/detail_touristacctraction_culture.dart';
import 'package:appquangbadulich/detailTouristAttraction/screens/detailTourist_history/detail_touristacctraction_history.dart';
import 'package:appquangbadulich/detailTouristAttraction/screens/detailTourist_specialDish/detail_touristacctraction_specialDish.dart';
import 'package:appquangbadulich/history/bloc/history_bloc.dart';
import 'package:appquangbadulich/history/screens/history_page.dart';
import 'package:appquangbadulich/imformationCustomer/bloc/imformationCus_bloc.dart';
import 'package:appquangbadulich/login/bloc/login_bloc.dart';
import 'package:appquangbadulich/login/screens/login_intro.dart';
import 'package:appquangbadulich/createAccount/screens/login_signUpSuccesful.dart';
import 'package:appquangbadulich/province/bloc/province_bloc.dart';
import 'package:appquangbadulich/region/bloc/region_bloc.dart';
import 'package:appquangbadulich/region/screens/region_page.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:appquangbadulich/searchTouristAttraction/srceens/searchTouristAttraction_page.dart';
import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/bloc/filterTourist_bloc.dart';
import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/screens/showAllTouristAttraction_page.dart';
import 'package:appquangbadulich/specialDish/bloc/specialDish_bloc.dart';
import 'package:appquangbadulich/specialDish/screens/specialDish_page.dart';
import 'package:appquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:appquangbadulich/touristAttraction/screens/touristAttraction_page.dart';
import 'package:appquangbadulich/updateName/bloc/updateName_bloc.dart';
import 'package:appquangbadulich/updateName/screens/updateName_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'createAccount/bloc/createAccount_bloc.dart';
import 'createAccount/screens/createAccont_page.dart';
import 'culture/screens/culture_page.dart';
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
        '/deleteAccount': (context) => DeleteAccountPage(),
        '/editAccount_password': (context) => UpdatePasswordPage(),
        '/editAccount_address': (context) => UpdateAddressPage(),
        '/editAccount_birthday': (context) => UpdateBirthdayPage(),
        '/editAccount_gmail': (context) => UpdateEmailPage(),
        '/editAccount_name': (context) => UpdateNamePage(),
        '/detailAccount': (context) => DetailAccountPage(),
        '/account': (context) => AccountPage(),
        '/searchTouristAttraction': (context) => SearchTouristAttractionPage(),
        '/login': (context) => LoginPage(),
        '/createAccount': (context) => CreateAccountPage(),
        '/regions': (context) => RegionPage(),
        '/cultures': (context) => CulturePage(),
        '/history': (context) => HistoryPage(),
        '/touristAttraction': (context) => TouristAttractionPage(),
        '/specialDishs': (context) => SpecialDishPage(),
        '/intro_login': (context) => LoginIntro(),
        '/createAccountSuccesful': (context) => CreateAccountSuccessful(),
        '/home': (context) => HomePage(),
        '/showAllTouristAttraction': (context) => ShowAllTouristAttraction(),
        '/detail_touriestAttraction_about': (context) =>
            DetailTouristAttraction_About(),
        '/detail_touriestAttraction_culture': (context) =>
            DetailTouristAttraction_Culture(),
        '/detail_touriestAttraction_specialDish': (context) =>
            DetailTouristAttraction_SpecialDish(),
        '/detail_touriestAttraction_history': (context) =>
            DetailTouristAttraction_History(),
        '/detail_content': (context) => DetailContent(dataIntroTourist: ''),
        '/detail_comment': (context) => CommentTourist(),
        '/detail_culture': (context) => DetailCulture(
              dataCulture: [],
            ),
        '/detail_history': (context) => DetailHistory(dataHistory: []),
        '/detail_specialtyDish': (context) =>
            DetailSpecialtyDish(dataSpecialtyDish: []),
      },
      home: LoginPage(),
    );
  }
}

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DeleteAccountBloc>(
          create: (context) => DeleteAccountBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdatePasswordBloc>(
          create: (context) => UpdatePasswordBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdateBirthdayBloc>(
          create: (context) => UpdateBirthdayBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdateAddressBloc>(
          create: (context) => UpdateAddressBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdateNameBloc>(
          create: (context) => UpdateNameBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdateEmailBloc>(
          create: (context) => UpdateEmailBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<CustomerBloc>(
          create: (context) => CustomerBloc(),
        ),
        BlocProvider<ProvinceBloc>(
          create: (context) => ProvinceBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<FilterTouristBloc>(
          create: (context) => FilterTouristBloc(
            userRepository: UserRepository(),
          ),
        ),
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
        ),
        BlocProvider<TouristAttractionBloc>(
          create: (context) => TouristAttractionBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<CultureBloc>(
          create: (context) => CultureBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<HistoryBloc>(
          create: (context) => HistoryBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<SpecialDishBloc>(
          create: (context) => SpecialDishBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<DetailTourist_AboutBloc>(
          create: (context) => DetailTourist_AboutBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<DetailTourist_CultureBloc>(
          create: (context) => DetailTourist_CultureBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<DetailTourist_SpecialDishBloc>(
          create: (context) => DetailTourist_SpecialDishBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<DetailTourist_HistoryBloc>(
          create: (context) => DetailTourist_HistoryBloc(
            userRepository: UserRepository(),
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}
