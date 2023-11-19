import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/account/screens/account_page.dart';
import 'package:userappquanbadulich/account/screens/detailAccount_page.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_bloc.dart';
import 'package:userappquanbadulich/checkCommentOwnership/bloc/checkCommentOwnership_bloc.dart';
import 'package:userappquanbadulich/comment/bloc/comment_bloc.dart';
import 'package:userappquanbadulich/comment/screens/comment_page.dart';
import 'package:userappquanbadulich/createAccount/screens/login_signUpSuccesful.dart';
import 'package:userappquanbadulich/culture/bloc/culture_bloc.dart';
import 'package:userappquanbadulich/deleteAccount/bloc/deleteAccount_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_culture/detailTourist_culture_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_history/detailTourist_history_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/bloc/bloc_tourist/detailTourist_about_bloc.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_byIdTourist_about/screens/detail_touristAttraction_about_page.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_culture/detail_touristacctraction_culture.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_history/detail_touristacctraction_history.dart';
import 'package:userappquanbadulich/detailTouristAttraction/screens/detailTourist_specialDish/detail_touristacctraction_specialDish.dart';
import 'package:userappquanbadulich/filterTypeTourist/bloc/filterTypeTourist_bloc.dart';
import 'package:userappquanbadulich/filterTypeTourist/screens/filterDetailTypeTourist_page.dart';
import 'package:userappquanbadulich/filterTypeTourist/screens/filterTypeTourist_page.dart';
import 'package:userappquanbadulich/history/bloc/history_bloc.dart';
import 'package:userappquanbadulich/history/screens/history_page.dart';
import 'package:userappquanbadulich/imformationCustomer/bloc/imformationCus_bloc.dart';
import 'package:userappquanbadulich/listFavoriteTouristAttraction/screens/listFavoriteTouristAttraction_page.dart';
import 'package:userappquanbadulich/login/bloc/login_bloc.dart';
import 'package:userappquanbadulich/login/screens/login_intro.dart';
import 'package:userappquanbadulich/province/bloc/province_bloc.dart';
import 'package:userappquanbadulich/region/bloc/region_bloc.dart';
import 'package:userappquanbadulich/region/screens/region_page.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';
import 'package:userappquanbadulich/searchTouristAttraction/srceens/searchTouristAttraction_page.dart';
import 'package:userappquanbadulich/showAllFilterCulture/bloc/filterCulture_bloc.dart';
import 'package:userappquanbadulich/showAllFilterCulture/screens/showAllCulture_page.dart';
import 'package:userappquanbadulich/showAllFilterHistory/bloc/filterHistory_bloc.dart';
import 'package:userappquanbadulich/showAllFilterHistory/screens/showAllHistory_page.dart';
import 'package:userappquanbadulich/showAllFilterSpecialDish/bloc/filterSpecialDish_bloc.dart';
import 'package:userappquanbadulich/showAllFilterSpecialDish/screens/showAllSpecial_page.dart';
import 'package:userappquanbadulich/showFilterAllTourist/bloc/filterTourist_bloc.dart';
import 'package:userappquanbadulich/showFilterAllTourist/screens/showAllTouristAttraction_page.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_bloc.dart';
import 'package:userappquanbadulich/specialDish/screens/specialDish_page.dart';
import 'package:userappquanbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:userappquanbadulich/touristAttraction/screens/touristAttraction_page.dart';
import 'package:userappquanbadulich/updateAddress/bloc/updateAddress_bloc.dart';
import 'package:userappquanbadulich/updateAddress/screens/updateAddress_page.dart';
import 'package:userappquanbadulich/updateBirthday/bloc/updateBirthday_bloc.dart';
import 'package:userappquanbadulich/updateBirthday/screens/updateBirthday_page.dart';
import 'package:userappquanbadulich/updateComment/bloc/updateComment_bloc.dart';
import 'package:userappquanbadulich/updateEmail/bloc/updateEmail_bloc.dart';
import 'package:userappquanbadulich/updateEmail/screens/updateEmail_page.dart';
import 'package:userappquanbadulich/updateImage/bloc/updateImage_bloc.dart';
import 'package:userappquanbadulich/updateImage/screens/updateImage_page.dart';
import 'package:userappquanbadulich/updateName/bloc/updateName_bloc.dart';
import 'package:userappquanbadulich/updateName/screens/updateName_page.dart';
import 'package:userappquanbadulich/updatePassword.dart/bloc/updatePassword_bloc.dart';
import 'package:userappquanbadulich/updatePassword.dart/screens/updatePassword_page.dart';

import 'addTouristAttractionToFavoritesList/bloc/addTouristToList_bloc.dart';
import 'comment/screens/updateComment_page.dart';
import 'createAccount/bloc/createAccount_bloc.dart';
import 'createAccount/screens/createAccont_page.dart';
import 'culture/screens/culture_page.dart';
import 'deleteAccount/screens/deleteAccount_page.dart';
import 'deleteComment/bloc/deleteComment_bloc.dart';
import 'detailTouristAttraction/screens/detailTourist_comment.dart';
import 'detailTouristAttraction/screens/detailTourist_content.dart';
import 'detailTouristAttraction/screens/detailTourist_culture.dart';
import 'detailTouristAttraction/screens/detailTourist_history.dart';
import 'detailTouristAttraction/screens/detailTourist_specialtyDish.dart';
import 'home/screens/home_page.dart';
import 'listFavoriteTouristAttraction/bloc/getTouristInFavoriteList_bloc.dart';
import 'login/screens/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/commentPage': (context) => CommentPage(
              idTourist: '',
              idCus: '',
            ),
        '/updateComment': (context) =>
            UpdateCommentPage(touristId: '', idCus: '', idcmt: ''),
        '/listFavoriteTouristAttraction': (context) =>
            ListFavoriteTouristAttractionPage(),
        '/updateImage': (context) => UpdateImagePage(),
        '/deleteAccount': (context) => DeleteAccountPage(),
        '/editAccount_password': (context) => UpdatePasswordPage(),
        '/editAccount_address': (context) => UpdateAddressPage(),
        '/editAccount_birthday': (context) => UpdateBirthdayPage(),
        '/editAccount_gmail': (context) => UpdateEmailPage(),
        '/editAccount_name': (context) => UpdateNamePage(),
        '/detailAccount': (context) => DetailAccountPage(),
        '/account': (context) => AccountPage(),
        '/searchTouristAttraction': (context) => SearchTouristAttractionPage(
              idCus: '',
            ),
        '/login': (context) => LoginPage(),
        '/createAccount': (context) => CreateAccountPage(),
        '/regions': (context) => RegionPage(),
        '/cultures': (context) => CulturePage(idCus: ''),
        '/history': (context) => HistoryPage(idCus: ''),
        '/touristAttraction': (context) => TouristAttractionPage(idCus: ''),
        '/specialDishs': (context) => SpecialDishPage(idCus: ''),
        '/intro_login': (context) => LoginIntro(),
        '/createAccountSuccesful': (context) => CreateAccountSuccessful(),
        '/home': (context) => HomePage(),
        '/detailFilterTypeTourist': (context) => DetailFilterTypeTourist(),
        '/showAllTouristAttraction': (context) =>
            ShowAllTouristAttraction(idCus: ''),
        '/showAllCulture': (context) => ShowAllCulure(idCus: ''),
        '/showAllSpecialDish': (context) => ShowAllSpecialDish(idCus: ''),
        '/showAllHistory': (context) => ShowAllHistory(idCus: ''),
        '/filterTypeTourist': (context) => FilterTypeTouristPage(idCus: ''),
        '/detail_touriestAttraction_about': (context) =>
            DetailTouristAttraction_AboutPage(),
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
      home: LoginIntro(),
    );
  }
}

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FilterTypeTouristBloc>(
          create: (context) => FilterTypeTouristBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<FilterHistoryBloc>(
          create: (context) => FilterHistoryBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<FilterSpecialDishBloc>(
          create: (context) => FilterSpecialDishBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<FilterCultureBloc>(
          create: (context) => FilterCultureBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdateCommentBloc>(
          create: (context) => UpdateCommentBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<DeleteCommentBloc>(
          create: (context) => DeleteCommentBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<CheckCommentOwnerShipBloc>(
          create: (context) => CheckCommentOwnerShipBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<AddCommentBloc>(
          create: (context) => AddCommentBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<CommentBloc>(
          create: (context) => CommentBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<GetTouristInFavoriteListBloc>(
          create: (context) => GetTouristInFavoriteListBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<AddAndRemoveTouristListBloc>(
          create: (context) => AddAndRemoveTouristListBloc(
            userRepository: UserRepository(),
          ),
        ),
        BlocProvider<UpdateImageBloc>(
          create: (context) => UpdateImageBloc(
            userRepository: UserRepository(),
          ),
        ),
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
