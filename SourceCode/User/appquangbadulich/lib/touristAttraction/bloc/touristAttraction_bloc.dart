import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:appquangbadulich/touristAttraction/bloc/touristAttraction_event.dart';
import 'package:appquangbadulich/touristAttraction/bloc/touristAttraction_state.dart';
import 'package:bloc/bloc.dart';

class TouristAttractionBloc extends Bloc<TouristAttractionEvent, TouristAttractionState> {
  final UserRepository userRepository;
  TouristAttractionBloc({required this.userRepository})
      : super(TouristAttractionInitial()) {
    on(<FetchTouristAttraction>(event, emit) async {
      try {
        emit(TouristAttractionLoading());
        final touristAttraction = await userRepository.getAllTouristAttraction();
        emit(TouristAttractionLoaded(touristAttraction: touristAttraction));
      } catch (e) {
        emit(TouristAttractionFailure(error: e.toString()));
      }
    });
  }
}
