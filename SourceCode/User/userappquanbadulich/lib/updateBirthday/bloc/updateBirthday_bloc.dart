import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/updateBirthday/bloc/updateBirthday_event.dart';
import 'package:userappquanbadulich/updateBirthday/bloc/updateBirthday_state.dart';

import '../../repositories/repositories.dart';

class UpdateBirthdayBloc extends Bloc<UpdateBirthdayEvent, UpdateBirthdayState> {
  final UserRepository userRepository;
  UpdateBirthdayBloc({required this.userRepository})
      : super(UpdateBirthdayInitial()) {
    on(<UpdateBirthdayButtonPressed>(event, emit) async {
      emit(UpdateBirthdayLoading());
      try {
        final customer =
            await userRepository.updateBirthday(event.idCus, event.newBirthday);
        if (customer != null) {
          print('Birthday thanh cong');
          emit(UpdateBirthdaySuccess(customer: customer));
        } else {
          print('Birthday that bai');
          emit(UpdateBirthdayFailure(
              error: 'Cập nhật Birthday không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdateBirthdayFailure(error: e.toString()));
      }
    });
  }
}
