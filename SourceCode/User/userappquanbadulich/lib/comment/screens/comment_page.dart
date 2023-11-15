import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_bloc.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_event.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_state.dart';
import 'package:userappquanbadulich/comment/bloc/comment_bloc.dart';
import 'package:userappquanbadulich/comment/bloc/comment_event.dart';
import 'package:userappquanbadulich/comment/bloc/comment_state.dart';

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

  @override
  void initState() {
    super.initState();
    idTourist = widget.idTourist;
    idCus = widget.idCus;
    context.read<CommentBloc>().add(LoadComment(idTourist: idTourist));
  }

  Future<void> _refreshComments() async {
    context.read<CommentBloc>().add(LoadComment(idTourist: idTourist));
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
                          context.read<AddCommentBloc>().add(
                                AddCommentButtonPress(
                                  idTourist: idTourist,
                                  idCus: idCus,
                                  commentData: commentContent,
                                ),
                              );
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(comment.idcmt);
                            },
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
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
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: const Text(
                                                    'Bạn có chắc chắn muốn xóa bình luận này không?',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        'HỦY',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    // Nút No
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Đóng dialog
                                                      },
                                                      child: const Text(
                                                        'XÓA',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue,
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
                                            Navigator.of(context)
                                                .pushNamed('/updateComment');
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
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        'assets/img/SP_CUL_3.jpg',
                                      ),
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
              return Text('Lỗi');
            },
          ),
        ],
      ),
    );
  }
}
