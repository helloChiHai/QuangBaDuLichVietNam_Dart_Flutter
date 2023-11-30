import 'package:equatable/equatable.dart';

abstract class UpdateTouristSpecialDishEvent extends Equatable {
  const UpdateTouristSpecialDishEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTouristSpecialDishButtonPressed extends UpdateTouristSpecialDishEvent {
  final String idTourist;
  final String idDish;
  final String nameDish;
  final String addressDish;
  final String? imgDish;
  final String dishIntroduction;
  UpdateTouristSpecialDishButtonPressed({
    required this.idTourist,
    required this.idDish,
    required this.nameDish,
    required this.addressDish,
    required this.imgDish,
    required this.dishIntroduction,
  });
  @override
  List<Object?> get props => [
        idTourist,
        idDish,
        nameDish,
        addressDish,
        imgDish,
        dishIntroduction,
      ];
}
