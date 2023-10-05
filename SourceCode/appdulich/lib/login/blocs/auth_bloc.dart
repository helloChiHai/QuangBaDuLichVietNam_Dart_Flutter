import 'package:appdulich/login/blocs/auth_events.dart';
import 'package:appdulich/login/blocs/auth_state.dart';
import 'package:appdulich/login/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class AuthBloc extends Bloc<AuthEvents, AuthState> {
//   AuthRepository repo;
//   AuthBloc(AuthState initialState, this.repo) : super(initialState);

//   @override
//   Stream<AuthState> mapEventToState(AuthEvents event) async* {
//     var pref = await SharedPreferences.getInstance();
//     if (event is StartEvent) {
//       yield LoginInitState();
//     } else if (event is LoginButtonPressed) {
//       yield LoginLoadingState();
//       var data = await repo.login(event.account, event.password);

//       if (data != null) {
//         var customerData = data['data'];

//         if (customerData != null) {
//           var type = customerData['type'];

//           pref.setString("token", customerData['token']);
//           pref.setInt("type", type);
//           pref.setString("account", customerData['account']);

//           if (type == 0 || type == 1) {
//             yield UserLogoinSuccessState();
//           } else {
//             yield LoginErrorState(message: 'Authentication error');
//           }
//         } else {
//           yield LoginErrorState(message: 'Customer data not found 1 ');
//         }
//       } else {
//         yield LoginErrorState(message: 'Customer data not found 23');
//       }
//     }
//   }
// }


abstract class AuthState {}

abstract class AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;
  AuthBloc(this.repo) : super(LoginInitState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    var pref = await SharedPreferences.getInstance();
    if (event is CheckConnectionEvent) {
      bool isConnected = await repo.checkServerConnection();
      if (isConnected) {
        yield ConnectionSuccessState();
      } else {
        yield ConnectionErrorState();
      }
    } else if (event is LoginButtonPressed) {
      // Handle login logic here...
    }
  }
}

class LoginInitState extends AuthState {}

class ConnectionSuccessState extends AuthState {}

class ConnectionErrorState extends AuthState {}

class CheckConnectionEvent extends AuthEvent {}

class LoginButtonPressed extends AuthEvent {}
