import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/update_tourist_history/bloc/update_tourist_history_event.dart';
import 'package:appadminquangbadulich/update_tourist_history/bloc/update_tourist_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTouristHistoryBloc
    extends Bloc<UpdateTouristHistoryEvent, UpdateTouristHistoryState> {
  final AdminRepository adminRepository;
  UpdateTouristHistoryBloc({required this.adminRepository})
      : super(UpdateTouristHistoryInitial()) {
    on(<UpdateTouristHistoryButtonPressed>(event, emit) async {
      emit(UpdateTouristHistoryLoading());
      try {
        final customer = await adminRepository.updateTouristHistory(
          event.idTourist,
          event.idHistoryStory,
          event.titleStoryStory,
          event.contentStoryStory,
          event.avatarHistory,
          event.imgHistory,
          event.videoHistory,
        );
        if (customer == 1) {
          emit(UpdateTouristHistorySuccess(success: 'Cập nhật thành công'));
        } else {
          emit(
              UpdateTouristHistoryFailure(error: 'Cập nhật không thành công!'));
        }
      } catch (e) {
        emit(UpdateTouristHistoryFailure(error: e.toString()));
      }
    });
  }
}
