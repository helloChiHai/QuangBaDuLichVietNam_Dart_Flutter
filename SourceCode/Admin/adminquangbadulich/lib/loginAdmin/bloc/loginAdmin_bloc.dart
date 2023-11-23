import 'package:adminquangbadulich/loginAdmin/bloc/loginAdmin_event.dart';
import 'package:adminquangbadulich/loginAdmin/bloc/loginAdmin_state.dart';
import 'package:adminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAdminBloc extends Bloc<LoginAdminEvent, LoginAdminState> {
  final AdminRepository adminRepository;

  LoginAdminBloc({required this.adminRepository}) : super(LoginAdminInitial()) {
    on<LoginAdminButtonPressed>((event, emit) async {
      emit(LoginAdminLoading());
      try {
        final result =
            await adminRepository.loginAdmin(event.account, event.password);
        if (result != null) {
          emit(LoginAdminSuccess(admin: result));
        } else {
          emit(LoginAdminFailure(error: 'Đăng nhập thất bại'));
        }
      } catch (e) {
        emit(LoginAdminFailure(error: e.toString()));
      }
    });
  }
}
