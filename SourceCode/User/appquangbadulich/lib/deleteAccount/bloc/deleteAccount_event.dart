import 'package:equatable/equatable.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();
  @override
  List<Object?> get props => [];
}

class DeleteAccountButtonPressed extends DeleteAccountEvent {
  final String idCus;
  DeleteAccountButtonPressed({required this.idCus});
  @override
  List<Object?> get props => [idCus];
}
