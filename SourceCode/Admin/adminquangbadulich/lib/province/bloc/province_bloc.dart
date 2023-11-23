import 'package:adminquangbadulich/province/bloc/province_event.dart';
import 'package:adminquangbadulich/province/bloc/province_state.dart';
import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final AdminRepository adminRepository;

  ProvinceBloc({required this.adminRepository}) 
  : super(ProvinceInitial()) {
    on(<FetchProvinces>(event, emit) async {
      try {
        emit(ProvinceLoading());
        final provinces = await adminRepository.getAllProvinces();
        emit(ProvinceLoaded(provinces: provinces));
      } catch (e) {
        emit(ProvinceFailure(error: e.toString()));
      }
    });
  }
}
