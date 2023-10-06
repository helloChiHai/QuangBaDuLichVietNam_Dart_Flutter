import 'package:appquangbadulich/bloc/auth_bloc/auth_bloc.dart';
import 'package:appquangbadulich/bloc/auth_bloc/auth_event.dart';
import 'package:appquangbadulich/bloc/login_bloc/login_event.dart';
import 'package:appquangbadulich/bloc/login_bloc/login_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({required this.userRepository, required this.authBloc})
      : super(LoginInitial()) {
    on<LoginButtonpressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token = await userRepository.login(event.email, event.password);
        authBloc.add(LoggedIn(token: token));
        emit(LoginInitial());
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
