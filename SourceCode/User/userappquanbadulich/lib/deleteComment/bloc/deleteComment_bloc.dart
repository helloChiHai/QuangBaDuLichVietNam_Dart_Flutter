import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:userappquanbadulich/deleteComment/bloc/deleteComment_event.dart';
import 'package:userappquanbadulich/deleteComment/bloc/deleteComment_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  final UserRepository userRepository;
  DeleteCommentBloc({required this.userRepository}) : super(DeleteCommentInitial()) {
    on(<DeleteCommentButtonPress>(event, emit) async {
      try {
        emit(DeleteCommentLoading());

        int result = await userRepository.deleteComment(
            event.touristId, event.idCus, event.idcmt);
        debugPrint('Result: $result');
        if (result == 1) {
          emit(DeleteCommentSuccess(message: 'xóa bình luận thành công'));
        } else {
          emit(DeleteCommentFailure(error: 'xóa bình luận thất bại'));
        }
      } catch (e) {
        emit(DeleteCommentFailure(error: 'Lỗi khi xóa bình luận: $e'));
      }
    });
  }
}
