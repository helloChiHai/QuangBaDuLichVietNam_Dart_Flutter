import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

abstract class FilterTouristState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterTouristInitial extends FilterTouristState {}

class FilterTouristLoading extends FilterTouristState {}

class FilterTouristLoaded extends FilterTouristState {
  final List<TouristAttractionModel> tourist;
  FilterTouristLoaded({required this.tourist});
  @override
  List<Object?> get props => [tourist];
}

class FilterTouristFailure extends FilterTouristState {
  final String error;
  FilterTouristFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
