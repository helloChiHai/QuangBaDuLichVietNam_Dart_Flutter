import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTourist_SpecialDishState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailTourist_SpecialDishInitial extends DetailTourist_SpecialDishState {}

class DetailTourist_SpecialDishLoading extends DetailTourist_SpecialDishState {}

class DetailTourist_SpecialDishLoaded extends DetailTourist_SpecialDishState {
  final TouristAttractionModel? touristAttraction;
  DetailTourist_SpecialDishLoaded({required this.touristAttraction});
  @override
  List<Object?> get props => [touristAttraction];
}

class DetailTourist_SpecialDishFailure extends DetailTourist_SpecialDishState {
  final String error;
  DetailTourist_SpecialDishFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
