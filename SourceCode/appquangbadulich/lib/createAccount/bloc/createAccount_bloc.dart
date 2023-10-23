import 'package:appquangbadulich/createAccount/bloc/createAccount_event.dart';
import 'package:appquangbadulich/createAccount/bloc/createAccount_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:bloc/bloc.dart';

class CreateAccountBloc extends Bloc<CreateAccontEvent, CreateAccountState> {
  final UserRepository userRepository;
  CreateAccountBloc({required this.userRepository})
      : super(CreateAccountInitial()) {
    on<CreateAccontButtonPressed>((event, emit) async {
      emit(CreateAccountLoading());
      try {
        final result = await userRepository.createAccount(event.email,
            event.password, event.name, event.address, event.birthday);
        if (result == 1) {
          await Future.delayed(const Duration(seconds: 2));
          emit(CreateAccountSuccess());
        } else if (result == -1) {
          emit(CreateAccountFailure(error: 'Email đã được sử dụng'));
        } else {
          emit(CreateAccountFailure(error: 'Tạo tài khoản thất bại'));
        }
      } catch (e) {
        emit(CreateAccountFailure(error: e.toString()));
      }
    });
  }
}
