import 'package:equatable/equatable.dart';

abstract class UpdateNameEvent extends Equatable {
  const UpdateNameEvent();
  @override
  List<Object?> get props => [];
}

class UpdateNameButtonPressed extends UpdateNameEvent {
  final String idCus;
  final String newName;
  UpdateNameButtonPressed({required this.idCus, required this.newName});
  @override
  List<Object?> get props => [idCus, newName];
}
