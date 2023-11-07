import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/bloc/filterTourist_event.dart';
import 'package:appquangbadulich/showFilterAllTouristCultureHistoryFood/bloc/filterTourist_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class FilterTouristBloc extends Bloc<FilterTouristEvent, FilterTouristState> {
  final UserRepository userRepository;
  FilterTouristBloc({required this.userRepository}):super(FilterTouristInitial()){
    on(<FilterTouristAttraction>(event, emit) async {
        try{
          emit(FilterTouristLoading());
          final tourist = await userRepository.filterTouristAttractionByIdRegionIdProvines(event.idRegion, event.idProvines);
          emit(FilterTouristLoaded(tourist: tourist));
        }catch(e){
          emit(FilterTouristFailure(error: e.toString()));
        }
    },);
  }
}
