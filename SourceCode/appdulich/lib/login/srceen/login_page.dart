// import 'package:appdulich/login/blocs/auth_bloc.dart';
// import 'package:appdulich/login/blocs/auth_events.dart';
// import 'package:appdulich/login/blocs/auth_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController account = TextEditingController();
//   TextEditingController password = TextEditingController();

//   late AuthBloc authBloc;

//   @override
//   void initState() {
//     authBloc = BlocProvider.of<AuthBloc>(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final msg = BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is LoginErrorState) {
//           return Text(state.message);
//         } else if (state is LoginLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );

//     final userAccount = TextField(
//       controller: account,
//       autofocus: false,
//       decoration: InputDecoration(hintText: 'Account'),
//     );

//     final userPassword = TextField(
//       controller: password,
//       autofocus: false,
//       decoration: InputDecoration(hintText: 'Password'),
//     );

//     final loginButton = Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: GestureDetector(
//         onTap: () {
//           authBloc.add(
//             LoginButtonPressed(
//               account: account.text,
//               password: password.text,
//             ),
//           );
//         },
//         child: const Text('Login'),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Logoin 123123'),
//       ),
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is UserLogoinSuccessState) {
//             Navigator.pushNamed(context, '/contacts');
//           } 
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               msg,
//               const SizedBox(height: 20),
//               userAccount,
//               const SizedBox(height: 20),
//               userPassword,
//               const SizedBox(height: 20),
//               loginButton
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
