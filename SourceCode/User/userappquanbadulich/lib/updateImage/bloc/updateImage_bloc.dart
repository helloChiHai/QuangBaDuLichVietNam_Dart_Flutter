import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userappquanbadulich/updateImage/bloc/updateImage_event.dart';
import 'package:userappquanbadulich/updateImage/bloc/updateImage_state.dart';

import '../../repositories/repositories.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  final UserRepository userRepository;
  UpdateImageBloc({required this.userRepository})
      : super(UpdateImageInitial()) {
    on(<UpdateImageButtonPressed>(event, emit) async {
      emit(UpdateImageLoading());
      try {
        final customer =
            await userRepository.updateImage(event.idCus, event.newImage);
        if (customer != null) {
          print('thanh cong');
          emit(UpdateImageSuccess(customer: customer));
        } else {
          print('that bai');
          emit(UpdateImageFailure(error: 'Cập nhật Image không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(UpdateImageFailure(error: e.toString()));
      }
    });
  }
}
