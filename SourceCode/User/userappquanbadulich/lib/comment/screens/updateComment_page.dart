import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../updateComment/bloc/updateComment_bloc.dart';
import '../../updateComment/bloc/updateComment_event.dart';
import '../../updateComment/bloc/updateComment_state.dart';
import '../bloc/comment_bloc.dart';
import '../bloc/comment_event.dart';

class UpdateCommentPage extends StatefulWidget {
  final String touristId;
  final String idCus;
  final String idcmt;
  const UpdateCommentPage({
    Key? key,
    required this.touristId,
    required this.idCus,
    required this.idcmt,
  });

  @override
  State<UpdateCommentPage> createState() => _UpdateCommentPageState();
}

class _UpdateCommentPageState extends State<UpdateCommentPage> {
  late String touristId;
  late String idCus;
  late String idcmt;

  @override
  void initState() {
    super.initState();
    touristId = widget.touristId;
    idCus = widget.idCus;
    idcmt = widget.idcmt;
  }

  Future<void> _refreshComments() async {
    context.read<CommentBloc>().add(LoadComment(idTourist: touristId));
  }

  TextEditingController newCommentDataController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Chỉnh sửa',
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
      body: BlocListener<UpdateCommentBloc, UpdateCommentState>(
        listener: (context, state) {
          if (state is UpdateCommentSuccess) {
            _refreshComments();
            newCommentDataController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật bình luận thành công',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
          } else if (state is UpdateCommentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Cập nhật bình luận thất bại',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: TextField(
                  controller: newCommentDataController,
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
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 99, 98, 98),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Hủy',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        if (newCommentDataController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Vui lòng nhập nội dung bình luận',
                              style: TextStyle(fontSize: 20),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          context.read<UpdateCommentBloc>().add(
                                UpdateCommentButtonPress(
                                  touristId: touristId,
                                  idCus: idCus,
                                  idcmt: idcmt,
                                  newCommentData: newCommentDataController.text,
                                ),
                              );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Cập nhật',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
