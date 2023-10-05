import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitState extends AuthState {}

class LoginLoadingState extends AuthState {}

class UserLogoinSuccessState extends AuthState {}

class AdminLogoinSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;
  LoginErrorState({required this.message});
}
