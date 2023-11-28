import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:appadminquangbadulich/totalUser/bloc/totalUser_event.dart';
import 'package:appadminquangbadulich/totalUser/bloc/totalUser_state.dart';
import 'package:bloc/bloc.dart';

class TotalUserBloc extends Bloc<TotalUserEvent, TotalUserState> {
  final AdminRepository adminRepository;
  TotalUserBloc({required this.adminRepository}) : super(TotalUserInitial()) {
    on(<ToTalUser>(event, emit) async {
      try {
        emit(TotalUserLoading());
        final totalUser = await adminRepository.totalUser();
        emit(TotalUserLoaded(totalUser: totalUser));
      } catch (e) {
        emit(TotalUserFailure(error: e.toString()));
      }
    });
  }
}
