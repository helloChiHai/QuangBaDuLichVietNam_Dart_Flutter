import 'package:equatable/equatable.dart';

abstract class UpdateBirthdayEvent extends Equatable {
  const UpdateBirthdayEvent();
  @override
  List<Object?> get props => [];
}

class UpdateBirthdayButtonPressed extends UpdateBirthdayEvent {
  final String idCus;
  final String newBirthday;
  UpdateBirthdayButtonPressed({required this.idCus, required this.newBirthday});
  @override
  List<Object?> get props => [idCus, newBirthday];
}
