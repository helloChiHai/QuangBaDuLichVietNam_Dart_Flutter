import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:adminquangbadulich/showFilterAllTourist/bloc/filterTourist_event.dart';
import 'package:adminquangbadulich/showFilterAllTourist/bloc/filterTourist_state.dart';
import 'package:bloc/bloc.dart';

class FilterTouristBloc extends Bloc<FilterTouristEvent, FilterTouristState> {
  final AdminRepository adminRepository;
  FilterTouristBloc({required this.adminRepository}):super(FilterTouristInitial()){
    on(<FilterTouristAttraction>(event, emit) async {
        try{
          emit(FilterTouristLoading());
          final tourist = await adminRepository.filterTouristAttractionByIdRegionIdProvines(event.idRegion, event.idProvines);
          emit(FilterTouristLoaded(tourist: tourist));
        }catch(e){
          emit(FilterTouristFailure(error: e.toString()));
        }
    },);
  }
}
