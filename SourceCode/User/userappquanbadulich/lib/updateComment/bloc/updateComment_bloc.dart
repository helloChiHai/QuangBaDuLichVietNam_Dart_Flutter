import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';
import 'package:userappquanbadulich/updateComment/bloc/updateComment_event.dart';
import 'package:userappquanbadulich/updateComment/bloc/updateComment_state.dart';

class UpdateCommentBloc extends Bloc<UpdateCommentEvent, UpdateCommentState> {
  final UserRepository userRepository;
  UpdateCommentBloc({required this.userRepository})
      : super(UpdateCommentInitial()) {
    on(<UpdateCommentButtonPress>(event, emit) async {
      try {
        emit(UpdateCommentLoading());

        int result = await userRepository.updateComment(
            event.touristId, event.idCus, event.idcmt, event.newCommentData);
        debugPrint('Result: $result');
        if (result == 1) {
          emit(UpdateCommentSuccess(message: 'cập nhật bình luận thành công'));


          
        } else {
          emit(UpdateCommentFailure(error: 'cập nhật bình luận thất bại'));
        }
      } catch (e) {
        emit(UpdateCommentFailure(error: 'Lỗi khi cập nhật bình luận: $e'));
      }
    });
  }
}
