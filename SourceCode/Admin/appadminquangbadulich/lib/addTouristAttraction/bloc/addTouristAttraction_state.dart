import 'package:equatable/equatable.dart';

abstract class AddTouristAttractionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTouristAttractionInitial extends AddTouristAttractionState {}

class AddTouristAttractionLoading extends AddTouristAttractionState {}

class AddTouristAttractionSuccess extends AddTouristAttractionState {}

class AddTouristAttractionFailure extends AddTouristAttractionState {
  final String error;
  AddTouristAttractionFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
