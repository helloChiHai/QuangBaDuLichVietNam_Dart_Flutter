import 'package:appadminquangbadulich/deleteTouristAttraction/bloc/deleteTouristAttraction_event.dart';
import 'package:appadminquangbadulich/deleteTouristAttraction/bloc/deleteTouristAttraction_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class DeleteTouristAttractionBloc
    extends Bloc<DeleteTouristAttractionEvent, DeleteTouristAttractionState> {
  final AdminRepository adminRepository;
  DeleteTouristAttractionBloc({required this.adminRepository})
      : super(DeleteTouristAttractionInitial()) {
    on(<DeleteTouristAttractionButtonPress>(event, emit) async {
      try {
        emit(DeleteTouristAttractionLoading());

        int result =
            await adminRepository.deleteTouristAttraction(event.touristId);
        debugPrint('Result: $result');
        if (result == 1) {
          emit(DeleteTouristAttractionSuccess(
              message: 'xóa bình luận thành công'));
        } else if (result == 0) {
          emit(DeleteTouristAttractionFailure(
              error: 'Xóa thất bại do không tìm thấy địa điểm'));
        } else if (result == -1) {
          emit(DeleteTouristAttractionFailure(error: 'Lỗi kết nối server'));
        }
      } catch (e) {
        emit(
            DeleteTouristAttractionFailure(error: 'Lỗi khi xóa bình luận: $e'));
      }
    });
  }
}
