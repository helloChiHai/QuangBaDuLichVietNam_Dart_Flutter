import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_event.dart';
import 'package:appadminquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class DetailTourist_SpecialDishBloc
    extends Bloc<DetailTourist_SpecialDishEvent, DetailTourist_SpecialDishState> {
  final AdminRepository adminRepository;
  DetailTourist_SpecialDishBloc({required this.adminRepository})
      : super(DetailTourist_SpecialDishInitial()) {
    on<getTouristWithSpecialDish>(
      (event, emit) async {
        emit(DetailTourist_SpecialDishLoading());
        try {
          final tourist =
              await adminRepository.getTouristWithSpecialDish(event.idDish);
          if (tourist != null) {
            emit(DetailTourist_SpecialDishLoaded(touristAttraction: tourist));
          } else {
            DetailTourist_SpecialDishFailure(error: 'bị lỗi');
          }
        } catch (e) {
          emit(DetailTourist_SpecialDishFailure(error: e.toString()));
        }
      },
    );
  }
}
