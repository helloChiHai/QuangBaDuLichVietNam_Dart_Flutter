import 'package:appquangbadulich/detailTouristAttraction/bloc/detailTouristAttraction_event.dart';
import 'package:appquangbadulich/detailTouristAttraction/bloc/detailTouristAttraction_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class DetailTouristAttractionBloc
    extends Bloc<DetailTouristAcctractionEvent, DetailTouristAttractionState> {
  final UserRepository userRepository;
  DetailTouristAttractionBloc({required this.userRepository})
      : super(DetailTouristInitial()) {
    on<getTouristWithCulture>(
      (event, emit) async {
        emit(DetailTouristLoading());
        try {
          final tourist =
              await userRepository.getTouristWithCulture(event.idCulture);
          if (tourist != null) {
            emit(DetailTouristLoaded(touristAttraction: tourist));
          } else {
            DetailTouristFailure(error: 'bị lỗi');
          }
        } catch (e) {
          emit(DetailTouristFailure(error: e.toString()));
        }
      },
    );
  }
}
