import 'package:appquangbadulich/deleteAccount/bloc/deleteAccount_event.dart';
import 'package:appquangbadulich/deleteAccount/bloc/deleteAccount_state.dart';
import 'package:appquangbadulich/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final UserRepository userRepository;
  DeleteAccountBloc({required this.userRepository})
      : super(DeleteAccountInitial()) {
    on(<DeleteAccountButtonPressed>(event, emit) async {
      emit(DeleteAccountLoading());
      try {
        final customer = await userRepository.deleteAccount(event.idCus);
        if (customer == 1) {
          print('DeleteAccount thanh cong');
          emit(DeleteAccountSuccess());
        } else {
          print('DeleteAccount that bai');
          emit(DeleteAccountFailure(error: 'DeleteAccount không thành công!'));
        }
      } catch (e) {
        print(e.toString());
        emit(DeleteAccountFailure(error: e.toString()));
      }
    });
  }
}
