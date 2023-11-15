import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/comment/bloc/comment_bloc.dart';
import 'package:userappquanbadulich/comment/bloc/comment_event.dart';
import 'package:userappquanbadulich/comment/bloc/comment_state.dart';

class CommentPage extends StatefulWidget {
  final String idTourist;
  const CommentPage({Key? key, required this.idTourist});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late String idTourist;
  @override
  void initState() {
    super.initState();
    idTourist = widget.idTourist;
    context.read<CommentBloc>().add(LoadComment(idTourist: idTourist));
  }

  void _refreshComments() {
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
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      size: 35,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              if (state is CommentLoading) {
                return CircularProgressIndicator(); // Hiển thị biểu tượng loading khi đang tải
              } else if (state is CommentLoaded) {
                final comments = state.comments;
                return comments.isEmpty
                    ? Container(
                        child: Text('khong co comment'),
                      )
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];
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
                                                    builder:
                                                        (BuildContext context) {
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
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                              'HỦY',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          // Nút No
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Đóng dialog
                                                            },
                                                            child: const Text(
                                                              'XÓA',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color:
                                                                    Colors.blue,
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
                                                      .pushNamed(
                                                          '/updateComment');
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 244, 242, 242),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        comment.nameCus,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                return Text('Lỗi: ${state.error}');
              }
              return Text('Lỗi');
            },
          ),
        ],
      ),
    );
  }
}
