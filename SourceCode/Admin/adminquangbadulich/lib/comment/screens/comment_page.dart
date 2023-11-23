import 'dart:convert';
import 'dart:typed_data';

import 'package:adminquangbadulich/comment/bloc/comment_bloc.dart';
import 'package:adminquangbadulich/comment/bloc/comment_event.dart';
import 'package:adminquangbadulich/comment/bloc/comment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentPage extends StatefulWidget {
  final String idTourist;
  const CommentPage({Key? key, required this.idTourist});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late String idTourist;
  TextEditingController contentCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idTourist = widget.idTourist;
    context.read<CommentBloc>().add(LoadComment(idTourist: idTourist));
  }

  Future<void> _refreshComments() async {
    context.read<CommentBloc>().add(LoadComment(idTourist: idTourist));
  }

  Future<Widget> _buildImage(String? imgCus) async {
    if (imgCus != null && imgCus.isNotEmpty) {
      try {
        List<int> imageBytes = Base64Decoder().convert(imgCus);
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.memory(
                Uint8List.fromList(imageBytes),
                fit: BoxFit.cover,
              ).image,
            ),
          ),
        );
      } catch (e) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/img/$imgCus'),
            ),
          ),
        );
      }
    } else {
      return Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/img_12.png'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: TextField(
                    controller: contentCommentController,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      hintText: 'Bạn đang nghĩ gì á?',
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return const CircularProgressIndicator();
              } else if (state is CommentLoaded) {
                final comments = state.comments;
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final sortedComments = List.from(comments);
                      sortedComments
                          .sort((a, b) => b.atTime.compareTo(a.atTime));
                      final comment = sortedComments[index];
                      return Column(
                        children: [
                          Container(
                              color: Colors.white,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: FutureBuilder<Widget>(
                                      future: _buildImage(comment.imgCus),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Widget> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return snapshot.data ?? Container();
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 244, 242, 242),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  comment.nameCus,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  comment.content,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            comment.atTime,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      );
                    },
                  ),
                );
              } else if (state is CommentFailure) {
                print(state.error);
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.messenger,
                        size: 150,
                        color: Colors.grey,
                      ),
                      Text(
                        'Chưa có bình luận nào',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Hãy là người đầu tiên bình luận',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return const Text('Lỗi');
            },
          ),
        ],
      ),
    );
  }
}
