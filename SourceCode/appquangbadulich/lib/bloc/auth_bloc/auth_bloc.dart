import 'package:bloc/bloc.dart';
import 'package:appquangbadulich/bloc/auth_bloc/auth_event.dart';
import 'package:appquangbadulich/bloc/auth_bloc/auth_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthBloc({required this.userRepository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await userRepository.persisToken(event.token);
      emit(AuthAuthenticated());
    });

    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await userRepository.deleteToken();
      emit(AuthUnauthenticated());
    });
  }
}
