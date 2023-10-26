import 'package:appquangbadulich/login/bloc/login_bloc.dart';
import 'package:appquangbadulich/login/screens/login_intro.dart';
import 'package:appquangbadulich/login/screens/login_signUpSuccesful.dart';
import 'package:appquangbadulich/region/bloc/region_bloc.dart';
import 'package:appquangbadulich/region/screens/region_page.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'createAccount/bloc/createAccount_bloc.dart';
import 'createAccount/screens/createAccont_page.dart';
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
        '/login_signupsuccesful': (context) => LoginSignUpSuccessful(),
      },
      home: LoginIntro(), // Trang chính mặc định là Đăng nhập
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


















// import 'package:appquangbadulich/login/bloc/login_bloc.dart';
// import 'package:appquangbadulich/login/bloc/login_state.dart';
// import 'package:appquangbadulich/createAccount/screens/createAccount_form.dart';
// import 'package:appquangbadulich/repositories/repositories.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'login/screens/login_form.dart';

// class MyApp extends StatelessWidget {
//   final userRepository = UserRepository();
//   final logBloc = LoginBloc(userRepository: UserRepository());

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/createAccont': (context) => CreateAccountForm(),
//       },
//       home: BlocProvider(
//         create: (context) => logBloc,
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Flutter Bloc Login Example'),
//           ),
//           body: BlocBuilder<LoginBloc, LoginState>(
//             builder: (context, state) {
//               if (state is LoginInitial) {
//                 return LoginForm();
//               } else if (state is LoginLoading) {
//                 return const CircularProgressIndicator();
//               } else if (state is LoginSuccess) {
//                 Future.delayed(Duration.zero, () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       backgroundColor: Colors.green,
//                       content: Text('Đăng nhập thành công!'),
//                     ),
//                   );
//                 });
//                 return Text('Đăng nhập thành công: ${state.customer.name}');
//               } else if (state is LoginFailure) {
//                 Future.delayed(Duration.zero, () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       backgroundColor: Colors.red,
//                       content: Text('Đăng nhập thất bại!'),
//                     ),
//                   );
//                 });
//                 return LoginForm();
//               } else {
//                 return Container();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   final userRepository = UserRepository();
//   final loginBloc = LoginBloc(userRepository: userRepository);

//   runApp(
//     BlocProvider(
//       create: (context) => loginBloc,
//       child: MyApp(),
//     ),
//   );
// }
