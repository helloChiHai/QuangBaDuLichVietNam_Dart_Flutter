import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DetailTourist_SpecialDishEvent extends Equatable {
  const DetailTourist_SpecialDishEvent();
  @override
  List<Object?> get props => [];
}

class getTouristWithSpecialDish extends DetailTourist_SpecialDishEvent {
  final String idDish;
  getTouristWithSpecialDish({required this.idDish});

  @override
  List<Object?> get props => [idDish];
}
