import 'package:appquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_event.dart';
import 'package:appquangbadulich/detailTouristAttraction/bloc/bloc_specialDish/detailTourist_specialDish_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class DetailTourist_SpecialDishBloc
    extends Bloc<DetailTourist_SpecialDishEvent, DetailTourist_SpecialDishState> {
  final UserRepository userRepository;
  DetailTourist_SpecialDishBloc({required this.userRepository})
      : super(DetailTourist_SpecialDishInitial()) {
    on<getTouristWithSpecialDish>(
      (event, emit) async {
        emit(DetailTourist_SpecialDishLoading());
        try {
          final tourist =
              await userRepository.getTouristWithSpecialDish(event.idDish);
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
