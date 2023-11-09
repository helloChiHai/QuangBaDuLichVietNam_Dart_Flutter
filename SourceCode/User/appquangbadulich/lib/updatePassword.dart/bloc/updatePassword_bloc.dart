import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:appquangbadulich/updatePassword.dart/bloc/updatePassword_event.dart';
import 'package:appquangbadulich/updatePassword.dart/bloc/updatePassword_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UserRepository userRepository;
  UpdatePasswordBloc({required this.userRepository}) : super(UpdatePasswordInitial()) {
    on(<UpdatePasswordButtonPressed>(event, emit) async {
      emit(UpdatePasswordLoading());
      try {
        final customer =
            await userRepository.updatePassword(event.idCus, event.newPassword);
        if (customer != null) {
          print('Password thanh cong');
          emit(UpdatePasswordSuccess(customer: customer));
        } else {
          print('Password that bai');
          emit(UpdatePasswordFailure(error: 'Cập nhật Password không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdatePasswordFailure(error: e.toString()));
      }
    });
  }
}
