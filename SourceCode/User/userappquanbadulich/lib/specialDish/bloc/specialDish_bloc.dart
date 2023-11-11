import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_event.dart';
import 'package:userappquanbadulich/specialDish/bloc/specialDish_state.dart';

class SpecialDishBloc extends Bloc<SpecialDishEvent, SpecialDishState> {
  final UserRepository userRepository;
  SpecialDishBloc({required this.userRepository})
      : super(SpecialDishInitial()) {
    on(<FetchSpecialDish>(event, emit) async {
      try {
        emit(SpecialDishLoading());
        final specialDishs = await userRepository.getSpecialDish();
        emit(SpecialDishLoaded(specialDishs: specialDishs));
      } catch (e) {
        emit(SpecialDishFailure(error: e.toString()));
      }
    });
  }
}
