// import 'package:appdulich/login/blocs/auth_bloc.dart';
// import 'package:appdulich/login/blocs/auth_state.dart';
// import 'package:appdulich/login/repository/auth_repo.dart';
// import 'package:appdulich/login/srceen/get_contacts.dart';
// import 'package:appdulich/login/srceen/post_contacts.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'login/srceen/MyHomePage.dart';
// import 'login/srceen/login_page.dart';

// void main() async {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My App',
//       home: MyHomePage(),
//     );
//   }
// }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider(
// //           create: (context) => AuthBloc(
// //             LoginInitState(),
// //             AuthRepository(),
// //           ),
// //         ),
// //       ],
// //       child: MaterialApp(
// //         initialRoute: '/',
// //         routes: {
// //           '/': (context) => LoginPage(),
// //           'contacts': (context) => Contact(),
// //           'addcontact': (context) => AddContacts(),
// //         },
// //       ),
// //     );
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/blocs/auth_bloc.dart';
import 'login/repository/auth_repo.dart';

void main() {
  final authRepo = AuthRepository();
  final authBloc = AuthBloc(authRepo);

  runApp(MyApp(authBloc: authBloc));
}
class MyApp extends StatelessWidget {
  final AuthBloc authBloc;

  MyApp({required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: BlocProvider<AuthBloc>(
        create: (context) => authBloc,
        child: MyHomePage(authBloc: authBloc), // Truyền authBloc vào MyHomePage
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  final AuthBloc authBloc;

  MyHomePage({required this.authBloc});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String connectionResult = ""; // Biến để theo dõi kết quả kiểm tra kết nối

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Kiểm tra kết nối và cập nhật biến connectionResult
                bool isConnected = await widget.authBloc.repo.checkServerConnection();
                setState(() {
                  connectionResult = isConnected ? "Kết nối thành công" : "Kết nối thất bại";
                });

                // Hiển thị thông báo bằng ScaffoldMessenger
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(connectionResult),
                    backgroundColor: isConnected ? Colors.green : Colors.red,
                  ),
                );
              },
              child: Text('Kiểm tra kết nối'),
            ),
          ],
        ),
      ),
    );
  }
}

