import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_bloc.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_event.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_state.dart';
import 'package:userappquanbadulich/comment/bloc/comment_bloc.dart';
import 'package:userappquanbadulich/comment/bloc/comment_event.dart';
import 'package:userappquanbadulich/comment/bloc/comment_state.dart';
import 'package:userappquanbadulich/comment/screens/updateComment_page.dart';

import '../../deleteComment/bloc/deleteComment_bloc.dart';
import '../../deleteComment/bloc/deleteComment_event.dart';
import '../../deleteComment/bloc/deleteComment_state.dart';

class CommentPage extends StatefulWidget {
  final String idTourist;
  final String idCus;
  const CommentPage({Key? key, required this.idTourist, required this.idCus});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late String idTourist;
  late String idCus;
  TextEditingController contentCommentController = TextEditingController();
  List<String> badWords = ["tục tiểu", "từ tục", "cc", "cdmm", "mm", "fuck", "f*"];

  @override
  void initState() {
    super.initState();
    idTourist = widget.idTourist;
    idCus = widget.idCus;
    context.read<CommentBloc>().add(LoadComment(idTourist: idTourist));
  }

  bool containsBadWords(String comment, List<String> badWords) {
    return badWords
        .any((word) => comment.toLowerCase().contains(word.toLowerCase()));
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
                BlocListener<AddCommentBloc, AddCommentState>(
                  listener: (context, state) {
                    if (state is AddCommentSuccess) {
                      contentCommentController.clear();
                      _refreshComments();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Thêm bình luận thành công',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (state is AddCommentFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Thêm bình luận thất bại',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                        String commentContent = contentCommentController.text;
                        if (commentContent.isNotEmpty) {
                          if (containsBadWords(commentContent, badWords)) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              const snackBar = SnackBar(
                                content: Text(
                                  'Bình luận không hợp lệ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          } else {
                            context.read<AddCommentBloc>().add(
                                  AddCommentButtonPress(
                                    idTourist: idTourist,
                                    idCus: idCus,
                                    commentData: commentContent,
                                  ),
                                );
                          }
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            const snackBar = SnackBar(
                              content: Text(
                                'Nội dung bình luận không được để trống',
                                style: TextStyle(fontSize: 20),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 35,
                        color: Colors.blue,
                      ),
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
                          GestureDetector(
                            onLongPress: () {
                              idCus != comment.idCus
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Bạn không có quyền xóa hay chỉnh sửa bình luận này',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 2),
                                    ))
                                  : showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return BlocListener<DeleteCommentBloc,
                                            DeleteCommentState>(
                                          listener: (context, state) {
                                            if (state is DeleteCommentSuccess) {
                                              final result = state.message;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  result,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                backgroundColor: Colors.green,
                                                duration:
                                                    const Duration(seconds: 2),
                                              ));
                                              Navigator.of(context).pop();
                                              _refreshComments();
                                            }
                                            if (state is DeleteCommentFailure) {
                                              final result = state.error;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  result,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                ),
                                                backgroundColor: Colors.red,
                                                duration:
                                                    const Duration(seconds: 2),
                                              ));
                                            }
                                          },
                                          child: Container(
                                            height: 150,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 20,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          content: const Text(
                                                            'Bạn có chắc chắn muốn xóa bình luận này không?',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Text(
                                                                'HỦY',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            // Nút No
                                                            TextButton(
                                                              onPressed: () {
                                                                BlocProvider.of<
                                                                            DeleteCommentBloc>(
                                                                        context)
                                                                    .add(
                                                                  DeleteCommentButtonPress(
                                                                    touristId:
                                                                        idTourist,
                                                                    idCus: comment
                                                                        .idCus,
                                                                    idcmt: comment
                                                                        .idcmt,
                                                                  ),
                                                                );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Đóng dialog
                                                              },
                                                              child: const Text(
                                                                'XÓA',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        size: 30,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        'Xóa',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateCommentPage(
                                                            touristId:
                                                                idTourist,
                                                            idCus: idCus,
                                                            idcmt:
                                                                comment.idcmt,
                                                          ),
                                                        ));
                                                  },
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.update_sharp,
                                                        size: 30,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        'Chỉnh sửa',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    // child: CircleAvatar(
                                    //   radius: 30,
                                    //   backgroundImage: AssetImage(
                                    //     'assets/img/img_12.png',
                                    //   ),
                                    // ),
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
                            ),
                          ),
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

  @override
  void dispose() {
    super.dispose();
  }
}
