import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/update_tourist_specialDish/bloc/update_tourist_specialDish_event.dart';
import 'package:appadminquangbadulich/update_tourist_specialDish/bloc/update_tourist_specialDish_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTouristSpeicalDishBloc
    extends Bloc<UpdateTouristSpecialDishEvent, UpdateTouristSpecialDishState> {
  final AdminRepository adminRepository;
  UpdateTouristSpeicalDishBloc({required this.adminRepository})
      : super(UpdateTouristSpecialDishInitial()) {
    on(<UpdateTouristSpecialDishButtonPressed>(event, emit) async {
      emit(UpdateTouristSpecialDishLoading());
      try {
        final customer = await adminRepository.updateTouristSpecialDish(
          event.idTourist,
          event.idDish,
          event.nameDish,
          event.addressDish,
          event.imgDish,
          event.dishIntroduction,
        );
        if (customer == 1) {
          emit(UpdateTouristSpecialDishSuccess(
              success: 'Cập nhật món ăn thành công'));
        } else {
          emit(UpdateTouristSpecialDishFailure(
              error: 'Cập nhật món ăn không thành công!'));
        }
      } catch (e) {
        emit(UpdateTouristSpecialDishFailure(error: e.toString()));
      }
    });
  }
}
