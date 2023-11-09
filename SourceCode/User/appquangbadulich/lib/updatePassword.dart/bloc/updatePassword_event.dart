import 'package:equatable/equatable.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();
  @override
  List<Object?> get props => [];
}

class UpdatePasswordButtonPressed extends UpdatePasswordEvent {
  final String idCus;
  final String newPassword;
  UpdatePasswordButtonPressed({required this.idCus, required this.newPassword});
  @override
  List<Object?> get props => [idCus, newPassword];
}
