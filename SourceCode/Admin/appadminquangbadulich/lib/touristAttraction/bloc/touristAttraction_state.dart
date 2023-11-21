import 'package:equatable/equatable.dart';

import '../../model/touristAttractionModel.dart';

abstract class TouristAttractionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TouristAttractionInitial extends TouristAttractionState {}

class TouristAttractionLoading extends TouristAttractionState {}

class TouristAttractionLoaded extends TouristAttractionState {
  final List<TouristAttractionModel> touristAttraction;
  TouristAttractionLoaded({required this.touristAttraction});
  @override
  List<Object?> get props => [touristAttraction];
}

class TouristAttractionFailure extends TouristAttractionState {
  final String error;
  TouristAttractionFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
