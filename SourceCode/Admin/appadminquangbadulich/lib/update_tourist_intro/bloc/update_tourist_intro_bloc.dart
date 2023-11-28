import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/update_tourist_intro/bloc/update_tourist_intro_event.dart';
import 'package:appadminquangbadulich/update_tourist_intro/bloc/update_tourist_intro_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTouristIntroBloc
    extends Bloc<UpdateTouristIntroEvent, UpdateTouristIntroState> {
  final AdminRepository adminRepository;
  UpdateTouristIntroBloc({required this.adminRepository})
      : super(UpdateTouristIntroInitial()) {
    on(<UpdateTouristIntroButtonPressed>(event, emit) async {
      emit(UpdateTouristIntroLoading());
      try {
        final customer = await adminRepository.updateTouristIntro(
          event.idTourist,
          event.nameTourist,
          event.typeTourist,
          event.address,
          event.ticket,
          event.imgTourist,
          event.touristIntroduction,
          event.rightTime,
        );
        if (customer == 1) {
          emit(UpdateTouristIntroSuccess(success: 'Nhập thành công'));
        } else {
          emit(UpdateTouristIntroFailure(error: 'Cập nhật không thành công!'));
        }
      } catch (e) {
        emit(UpdateTouristIntroFailure(error: e.toString()));
      }
    });
  }
}
