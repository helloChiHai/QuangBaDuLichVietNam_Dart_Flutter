import 'package:appadminquangbadulich/homeAdmin/screens/homeAdmin_page.dart';
import 'package:appadminquangbadulich/loginAdmin/bloc/loginAdmin_bloc.dart';
import 'package:appadminquangbadulich/loginAdmin/screens/loginAdmin_page.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/touristAttraction/bloc/touristAttraction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeAdminPage(),
    );
  }
}
void main() {
  runApp(MultiBlocProvider(
    providers: [
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
