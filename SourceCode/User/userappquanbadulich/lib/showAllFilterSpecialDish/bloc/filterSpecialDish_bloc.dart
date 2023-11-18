import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';
import 'package:userappquanbadulich/showAllFilterSpecialDish/bloc/filterSpecialDish_state.dart';
import 'package:userappquanbadulich/showAllFilterSpecialDish/bloc/filterTourist_event.dart';

class FilterSpecialDishBloc extends Bloc<FilterSpecialDishEvent, FilterSpecialDishState> {
  final UserRepository userRepository;
  FilterSpecialDishBloc({required this.userRepository}):super(FilterSpecialDishInitial()){
    on(<FilterSpecialDishAttraction>(event, emit) async {
        try{
          emit(FilterSpecialDishLoading());
          final specialDish = await userRepository.filterSpecialDishByIdRegionIdProvines(event.idRegion, event.idProvines);
          emit(FilterSpecialDishLoaded(specialDish: specialDish));
        }catch(e){
          emit(FilterSpecialDishFailure(error: e.toString()));
        }
    },);
  }
}
