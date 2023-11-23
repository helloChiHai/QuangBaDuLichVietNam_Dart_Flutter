import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:adminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_event.dart';
import 'package:adminquangbadulich/totalTouristAttraction/bloc/totalTouristAttraction_state.dart';
import 'package:bloc/bloc.dart';

class TotalTouristAttractionBloc
    extends Bloc<TotalTouristAttractionEvent, TotalTouristAttractionState> {
  final AdminRepository adminRepository;
  TotalTouristAttractionBloc({required this.adminRepository})
      : super(TotalTouristAttractionInitial()) {
    on(<ToTalTouristAttraction>(event, emit) async {
      try {
        emit(TotalTouristAttractionLoading());
        final totaltouristAttraction =
            await adminRepository.totalTouristAttraction();
        emit(TotalTouristAttractionLoaded(
            totaltouristAttraction: totaltouristAttraction));
      } catch (e) {
        emit(TotalTouristAttractionFailure(error: e.toString()));
      }
    });
  }
}
