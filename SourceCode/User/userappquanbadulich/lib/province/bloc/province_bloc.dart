import 'package:bloc/bloc.dart';
import 'package:userappquanbadulich/province/bloc/province_event.dart';
import 'package:userappquanbadulich/province/bloc/province_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';

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
