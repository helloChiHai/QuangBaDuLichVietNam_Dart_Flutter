import 'package:equatable/equatable.dart';

abstract class TotalTouristAttractionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TotalTouristAttractionInitial extends TotalTouristAttractionState {}

class TotalTouristAttractionLoading extends TotalTouristAttractionState {}

class TotalTouristAttractionLoaded extends TotalTouristAttractionState {
  final int totaltouristAttraction;
  TotalTouristAttractionLoaded({required this.totaltouristAttraction});
  @override
  List<Object?> get props => [totaltouristAttraction];
}

class TotalTouristAttractionFailure extends TotalTouristAttractionState {
  final String error;
  TotalTouristAttractionFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
