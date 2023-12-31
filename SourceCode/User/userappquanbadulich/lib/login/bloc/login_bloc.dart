import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/login/bloc/login_event.dart';
import 'package:userappquanbadulich/login/bloc/login_state.dart';
import 'package:userappquanbadulich/repositories/repositories.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await userRepository.login(event.email, event.password);
        if (result != null) {
          emit(LoginSuccess(customer: result));
        } else {
          emit(LoginFailure(error: 'Đăng nhập thất bại'));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
