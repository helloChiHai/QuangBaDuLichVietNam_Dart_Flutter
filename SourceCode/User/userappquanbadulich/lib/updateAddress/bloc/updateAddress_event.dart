import 'package:equatable/equatable.dart';

abstract class UpdateAddressEvent extends Equatable {
  const UpdateAddressEvent();
  @override
  List<Object?> get props => [];
}

class UpdateAddressButtonPressed extends UpdateAddressEvent {
  final String idCus;
  final String newAddress;
  UpdateAddressButtonPressed({required this.idCus, required this.newAddress});
  @override
  List<Object?> get props => [idCus, newAddress];
}
