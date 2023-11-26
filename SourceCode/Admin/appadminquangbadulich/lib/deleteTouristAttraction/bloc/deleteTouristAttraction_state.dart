import 'package:equatable/equatable.dart';

abstract class DeleteTouristAttractionState extends Equatable {
  const DeleteTouristAttractionState();
  @override
  List<Object?> get props => [];
}

class DeleteTouristAttractionInitial extends DeleteTouristAttractionState {}

class DeleteTouristAttractionLoading extends DeleteTouristAttractionState {}

class DeleteTouristAttractionSuccess extends DeleteTouristAttractionState {
  final String message;
  DeleteTouristAttractionSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class DeleteTouristAttractionFailure extends DeleteTouristAttractionState {
  final String error;
  DeleteTouristAttractionFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
