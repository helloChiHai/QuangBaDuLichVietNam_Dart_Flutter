import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:adminquangbadulich/touristAttraction/bloc/touristAttraction_event.dart';
import 'package:adminquangbadulich/touristAttraction/bloc/touristAttraction_state.dart';
import 'package:bloc/bloc.dart';


class TouristAttractionBloc extends Bloc<TouristAttractionEvent, TouristAttractionState> {
  final AdminRepository adminRepository;
  TouristAttractionBloc({required this.adminRepository})
      : super(TouristAttractionInitial()) {
    on(<FetchTouristAttraction>(event, emit) async {
      try {
        emit(TouristAttractionLoading());
        final touristAttraction = await adminRepository.getAllTouristAttraction();
        emit(TouristAttractionLoaded(touristAttraction: touristAttraction));
      } catch (e) {
        emit(TouristAttractionFailure(error: e.toString()));
      }
    });
  }
}
