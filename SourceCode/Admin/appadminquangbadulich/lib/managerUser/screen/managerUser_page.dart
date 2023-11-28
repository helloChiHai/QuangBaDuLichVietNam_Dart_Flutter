import 'dart:convert';
import 'dart:typed_data';

import 'package:appadminquangbadulich/managerUser/bloc/userManagement_bloc.dart';
import 'package:appadminquangbadulich/managerUser/bloc/userManagement_event.dart';
import 'package:appadminquangbadulich/managerUser/bloc/userManagement_state.dart';
import 'package:appadminquangbadulich/totalUser/bloc/totalUser_bloc.dart';
import 'package:appadminquangbadulich/totalUser/bloc/totalUser_event.dart';
import 'package:appadminquangbadulich/totalUser/bloc/totalUser_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerUserPage extends StatefulWidget {
  const ManagerUserPage({super.key});

  @override
  State<ManagerUserPage> createState() => _ManagerUserPageState();
}

class _ManagerUserPageState extends State<ManagerUserPage> {
  @override
  void initState() {
    super.initState();

    context.read<UserManagementBloc>().add(FetchUser());
    context.read<TotalUserBloc>().add(ToTalUser());
  }

  Future<Widget> _buildImage(String? img) async {
    if (img != null && img.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(img);
        return Image.memory(
          Uint8List.fromList(imageBytes),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      } catch (e) {
        return Image.asset(
          'assets/img/$img',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        );
      }
    } else {
      return Image.asset(
        'assets/img/img_12.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: const Text(
          'Quản lý người dùng',
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<TotalUserBloc, TotalUserState>(
                    builder: (context, state) {
                      if (state is TotalUserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TotalUserLoaded) {
                        final uers = state.totalUser;
                        return Text(
                          'Tổng số người dùng: $uers',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        );
                      } else if (state is TotalUserFailure) {
                        return Text(
                          'Tổng số người dùng: ${state.error}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Danh sách người dùng:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<UserManagementBloc, UserManagementState>(
                      builder: (context, state) {
                        if (state is UserManagementLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is UserManagementLoaded) {
                          final users = state.user;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/detailCustomer',
                                      arguments: {
                                        'aboutUserData': user,
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FutureBuilder<Widget>(
                                          future: _buildImage(user.imgCus),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<Widget> snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return snapshot.data ??
                                                  Container();
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                        child: Container(
                                          height: 50,
                                          width: double.infinity,
                                          color: Colors.transparent,
                                          alignment: Alignment.bottomLeft,
                                          child: user.name.isNotEmpty
                                              ? Text(
                                                  user.name,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is UserManagementFailure) {
                          return Text('Lỗi: ${state.error}');
                        }
                        return Container(
                          width: double.infinity,
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 10),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(
                                  'assets/img/img_no_user.png',
                                ),
                                width: 180,
                                height: 180,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Không có người dùng',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
