import 'package:appquangbadulich/model/touristAttractionModel.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTouristAttractionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailTouristInitial extends DetailTouristAttractionState {}

class DetailTouristLoading extends DetailTouristAttractionState {}

class DetailTouristLoaded extends DetailTouristAttractionState {
  final TouristAttractionModel? touristAttraction;
  DetailTouristLoaded({required this.touristAttraction});
  @override
  List<Object?> get props => [touristAttraction];
}

class DetailTouristFailure extends DetailTouristAttractionState {
  final String error;
  DetailTouristFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
