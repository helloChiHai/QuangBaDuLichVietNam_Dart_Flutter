import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';
import 'package:userappquanbadulich/showAllFilterCulture/bloc/filterCulture_event.dart';
import 'package:userappquanbadulich/showAllFilterCulture/bloc/filterCulture_state.dart';

class FilterCultureBloc extends Bloc<FilterCultureEvent, FilterCultureState> {
  final UserRepository userRepository;
  FilterCultureBloc({required this.userRepository}):super(FilterCultureInitial()){
    on(<FilterCulture>(event, emit) async {
        try{
          emit(FilterCultureLoading());
          final culture = await userRepository.filterCultureByIdRegionIdProvines(event.idRegion, event.idProvines);
          emit(FilterCultureLoaded(culture: culture));
        }catch(e){
          emit(FilterCultureFailure(error: e.toString()));
        }
    },);
  }
}
