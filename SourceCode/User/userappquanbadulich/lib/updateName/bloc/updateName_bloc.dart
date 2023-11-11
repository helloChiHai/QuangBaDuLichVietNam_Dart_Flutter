import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/updateName/bloc/updateName_event.dart';
import 'package:userappquanbadulich/updateName/bloc/updateName_state.dart';

import '../../repositories/repositories.dart';

class UpdateNameBloc extends Bloc<UpdateNameEvent, UpdateNameState> {
  final UserRepository userRepository;
  UpdateNameBloc({required this.userRepository}) : super(UpdateNameInitial()) {
    on(<UpdateNameButtonPressed>(event, emit) async {
      emit(UpdateNameLoading());
      try {
        final customer =
            await userRepository.updateName(event.idCus, event.newName);
        if (customer != null) {
          print('name thanh cong');
          emit(UpdateNameSuccess(customer: customer));
        } else {
          print('name that bai');
          emit(UpdateNameFailure(error: 'Cập nhật Name không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdateNameFailure(error: e.toString()));
      }
    });
  }
}
