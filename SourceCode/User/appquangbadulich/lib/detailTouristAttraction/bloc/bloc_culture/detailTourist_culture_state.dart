import 'package:appquangbadulich/model/touristAttractionModel.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTourist_CultureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailTourist_CultureInitial extends DetailTourist_CultureState {}

class DetailTourist_CultureLoading extends DetailTourist_CultureState {}

class DetailTourist_CultureLoaded extends DetailTourist_CultureState {
  final TouristAttractionModel? touristAttraction;
  DetailTourist_CultureLoaded({required this.touristAttraction});
  @override
  List<Object?> get props => [touristAttraction];
}

class DetailTourist_CultureFailure extends DetailTourist_CultureState {
  final String error;
  DetailTourist_CultureFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
