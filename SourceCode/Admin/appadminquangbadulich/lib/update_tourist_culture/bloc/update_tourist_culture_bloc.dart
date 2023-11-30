import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/update_tourist_culture/bloc/update_tourist_culture_event.dart';
import 'package:appadminquangbadulich/update_tourist_culture/bloc/update_tourist_culture_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateTouristCultureBloc
    extends Bloc<UpdateTouristCultureEvent, UpdateTouristCultureState> {
  final AdminRepository adminRepository;
  UpdateTouristCultureBloc({required this.adminRepository})
      : super(UpdateTouristCultureInitial()) {
    on(<UpdateTouristCultureButtonPressed>(event, emit) async {
      emit(UpdateTouristCultureLoading());
      try {
        final customer = await adminRepository.updateTouristCulture(
          event.idTourist,
          event.idCulture,
          event.titleCulture,
          event.contentCulture,
          event.imgCulture,
        );
        if (customer == 1) {
          emit(UpdateTouristCultureSuccess(
              success: 'Cập nhật văn hóa thành công'));
        } else {
          emit(UpdateTouristCultureFailure(
              error: 'Cập nhật văn hóa không thành công!'));
        }
      } catch (e) {
        emit(UpdateTouristCultureFailure(error: e.toString()));
      }
    });
  }
}
