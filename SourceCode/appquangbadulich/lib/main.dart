// import 'package:appquangbadulich/login/bloc/auth_bloc/auth_bloc.dart';
// import 'package:appquangbadulich/login/bloc/auth_bloc/auth_event.dart';
// import 'package:appquangbadulich/login/bloc/auth_bloc/auth_state.dart';
// import 'package:appquangbadulich/repositories/repositories.dart';
// import 'package:appquangbadulich/login/screens/auth/login_screen.dart';
// import 'package:appquangbadulich/login/screens/main/main_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('${bloc.runtimeType} $change');
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     print('${bloc.runtimeType} $transition');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     super.onError(bloc, error, stackTrace);
//     print('${bloc.runtimeType} $stackTrace');
//   }
// }

// class MyApp extends StatelessWidget {
//   final UserRepository userRepository;
//   const MyApp({Key? key, required this.userRepository}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       locale: Locale('id', 'ID'),
//       theme: ThemeData(
//         fontFamily: 'Rubik',
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: BlocBuilder<AuthBloc, AuthState>(
//         builder: (context, state) {
//           if (state is AuthAuthenticated) {
//             return const MainScreen();
//           }
//           if (state is AuthUnauthenticated) {
//             return LoginScreen(userRepository: userRepository);
//           }
//           if (state is AuthLoading) {
//             return Scaffold(
//               body: Container(
//                 color: Colors.white,
//                 width: MediaQuery.of(context).size.width,
//                 child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 25,
//                       width: 25,
//                       child: CircularProgressIndicator(
//                         valueColor:
//                             AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
//                         strokeWidth: 4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//           return Scaffold(
//             body: Container(
//               color: Colors.white,
//               width: MediaQuery.of(context).size.width,
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 25,
//                     width: 25,
//                     child: CircularProgressIndicator(
//                       valueColor:
//                           AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
//                       strokeWidth: 4,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   Bloc.observer = SimpleBlocObserver();
//   final userRepository = UserRepository();

//   runApp(BlocProvider<AuthBloc>(
//     create: (context) {
//       return AuthBloc(userRepository: userRepository)..add(AppStarted());
//     },
//     child: MyApp(userRepository: userRepository),
//   ));
// }
