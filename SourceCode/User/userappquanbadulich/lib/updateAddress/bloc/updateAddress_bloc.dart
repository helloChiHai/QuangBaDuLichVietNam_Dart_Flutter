import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/updateAddress/bloc/updateAddress_event.dart';
import 'package:userappquanbadulich/updateAddress/bloc/updateAddress_state.dart';

import '../../repositories/repositories.dart';

class UpdateAddressBloc extends Bloc<UpdateAddressEvent, UpdateAddressState> {
  final UserRepository userRepository;
  UpdateAddressBloc({required this.userRepository})
      : super(UpdateAddressInitial()) {
    on(<UpdateAddressButtonPressed>(event, emit) async {
      emit(UpdateAddressLoading());
      try {
        final customer =
            await userRepository.updateAddress(event.idCus, event.newAddress);
        if (customer != null) {
          print('Address thanh cong');
          emit(UpdateAddressSuccess(customer: customer));
        } else {
          print('Address that bai');
          emit(UpdateAddressFailure(
              error: 'Cập nhật Address không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdateAddressFailure(error: e.toString()));
      }
    });
  }
}
