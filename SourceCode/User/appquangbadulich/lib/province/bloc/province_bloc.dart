import 'package:appquangbadulich/province/bloc/province_event.dart';
import 'package:appquangbadulich/province/bloc/province_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final UserRepository userRepository;

  ProvinceBloc({required this.userRepository}) 
  : super(ProvinceInitial()) {
    on(<FetchProvinces>(event, emit) async {
      try {
        emit(ProvinceLoading());
        final provinces = await userRepository.getAllProvinces();
        emit(ProvinceLoaded(provinces: provinces));
      } catch (e) {
        emit(ProvinceFailure(error: e.toString()));
      }
    });
  }
}
