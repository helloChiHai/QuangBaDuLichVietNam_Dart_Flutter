import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_event.dart';
import 'package:userappquanbadulich/addComment/bloc/addComment_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  final UserRepository userRepository;
  AddCommentBloc({required this.userRepository}) : super(AddCommentInitial()) {
    on(<AddCommentButtonPress>(event, emit) async {
      try {
        emit(AddCommentLoading());

        int result = await userRepository.addComment(
            event.idTourist, event.idCus, event.commentData);
        debugPrint('Result: $result');
        if (result == 1) {
          emit(AddCommentSuccess(message: 'Thêm bình luận thành công'));
        } else {
          emit(AddCommentFailure(error: 'Thêm bình luận thất bại'));
        }
      } catch (e) {
        emit(AddCommentFailure(error: 'Lỗi khi thêm bình luận: $e'));
      }
    });
  }
}
