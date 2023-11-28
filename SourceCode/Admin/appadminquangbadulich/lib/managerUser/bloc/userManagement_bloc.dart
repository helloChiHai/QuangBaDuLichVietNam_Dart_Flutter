import 'package:appadminquangbadulich/managerUser/bloc/userManagement_event.dart';
import 'package:appadminquangbadulich/managerUser/bloc/userManagement_state.dart';
import 'package:appadminquangbadulich/repositories/adminRepository.dart';
import 'package:bloc/bloc.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final AdminRepository adminRepository;
  UserManagementBloc({required this.adminRepository})
      : super(UserManagementInitial()) {
    on(<FetchUser>(event, emit) async {
      try {
        emit(UserManagementLoading());
        final user = await adminRepository.getAllCustomer();
        emit(UserManagementLoaded(user: user));
      } catch (e) {
        emit(UserManagementFailure(error: e.toString()));
      }
    });
  }
}
