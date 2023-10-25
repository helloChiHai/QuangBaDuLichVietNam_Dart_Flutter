import 'package:appquangbadulich/login/bloc/login_bloc.dart';
import 'package:appquangbadulich/login/bloc/login_state.dart';
import 'package:appquangbadulich/login/screens/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroductionScreen(
        pages: [
          buildIntroPage("assets/img/img_2.jpg", "Page 1", "This is page 1"),
          buildIntroPage("assets/img/img_3.jpg", "Page 2", "This is page 2"),
          buildIntroPage("assets/img/img_1.jpg", "Page 3", "This is page 3"),
        ],
        onDone: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        showSkipButton: true,
        skip: Text("Skip"),
        done: Text("Done"),
        showNextButton: false,
      ),
    );
  }

  PageViewModel buildIntroPage(String imagePath, String title, String body) {
    return PageViewModel(
      title: title,
      body: body,
      image: Stack(
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            left: 16,
            right: 16,
            child: Text(
              body,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}

// import 'package:appquangbadulich/login/bloc/login_bloc.dart';
// import 'package:appquangbadulich/login/bloc/login_state.dart';
// import 'package:appquangbadulich/login/screens/login_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:introduction_screen/introduction_screen.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Đăng nhập'),
//       ),
//       body: BlocListener<LoginBloc, LoginState>(
//         listener: (context, state) {
//           if (state is LoginSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Đăng nhập thành công!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           } else if (state is LoginFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Đăng nhập thất bại!'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         child: LoginForm(),
//       ),
//     );
//   }
// }
