import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:equatable/equatable.dart';

abstract class DetailTourist_AboutState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ignore: camel_case_types
class DetailTourist_AboutInitial extends DetailTourist_AboutState {}

// ignore: camel_case_types
class DetailTourist_AboutLoading extends DetailTourist_AboutState {}

// ignore: camel_case_types
class DetailTourist_AboutLoaded extends DetailTourist_AboutState {
  final TouristAttractionModel? touristAttraction;
  DetailTourist_AboutLoaded({required this.touristAttraction});
  @override
  List<Object?> get props => [touristAttraction];
}

// ignore: camel_case_types
class DetailTourist_AboutFailure extends DetailTourist_AboutState {
  final String error;
  DetailTourist_AboutFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
