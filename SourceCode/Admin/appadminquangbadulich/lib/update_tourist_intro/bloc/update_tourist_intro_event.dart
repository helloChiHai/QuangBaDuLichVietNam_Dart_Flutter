import 'package:equatable/equatable.dart';

abstract class UpdateTouristIntroEvent extends Equatable {
  const UpdateTouristIntroEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTouristIntroButtonPressed extends UpdateTouristIntroEvent {
  final String idTourist;
  final String nameTourist;
  final String typeTourist;
  final String address;
  final String ticket;
  final String? imgTourist;
  final String touristIntroduction;
  final String rightTime;
  UpdateTouristIntroButtonPressed({
    required this.idTourist,
    required this.nameTourist,
    required this.typeTourist,
    required this.address,
    required this.ticket,
    required this.imgTourist,
    required this.touristIntroduction,
    required this.rightTime,
  });
  @override
  List<Object?> get props => [
        idTourist,
        nameTourist,
        typeTourist,
        address,
        ticket,
        imgTourist,
        touristIntroduction,
        rightTime,
      ];
}
