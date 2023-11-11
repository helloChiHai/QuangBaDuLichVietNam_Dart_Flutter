import 'package:equatable/equatable.dart';

abstract class CreateAccountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateAccountInitial extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountSuccess extends CreateAccountState {}

class CreateAccountFailure extends CreateAccountState {
  final String error;
  CreateAccountFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
