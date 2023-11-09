import 'package:equatable/equatable.dart';

abstract class UpdateEmailEvent extends Equatable {
  const UpdateEmailEvent();
  @override
  List<Object?> get props => [];
}

class UpdateEmailButtonPressed extends UpdateEmailEvent {
  final String idCus;
  final String newEmail;
  UpdateEmailButtonPressed({required this.idCus, required this.newEmail});
  @override
  List<Object?> get props => [idCus, newEmail];
}
