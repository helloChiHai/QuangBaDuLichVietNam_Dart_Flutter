import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://genk.mediacdn.vn/2019/10/6/photo-1-1570370576251214106139.jpg"),
          ),
        ),
        title: const Text('AUTH WITH REST'),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     BlocProvider.of<AuthBloc>(context).add(LoggedOut());
          //   },
          //   icon: const Icon(EvaIcons.logOutOutline),
          // ),
        ],
      ),
      body: Center(
        child: Text('Main Screen'),
      ),
    );
  }
}
