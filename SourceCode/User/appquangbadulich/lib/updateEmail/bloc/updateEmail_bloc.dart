import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:appquangbadulich/updateEmail/bloc/updateEmail_event.dart';
import 'package:appquangbadulich/updateEmail/bloc/updateEmail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEmailBloc extends Bloc<UpdateEmailEvent, UpdateEmailState> {
  final UserRepository userRepository;
  UpdateEmailBloc({required this.userRepository})
      : super(UpdateEmailInitial()) {
    on(<UpdateEmailButtonPressed>(event, emit) async {
      emit(UpdateEmailLoading());
      try {
        final customer =
            await userRepository.updateEmail(event.idCus, event.newEmail);
        if (customer != null) {
          print('thanh cong');
          emit(UpdateEmailSuccess(customer: customer));
        } else {
          print('that bai');
          emit(UpdateEmailFailure(error: 'Cập nhật email không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdateEmailFailure(error: e.toString()));
      }
    });
  }
}
