import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

abstract class FilterTypeTouristState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterTypeTouristInitial extends FilterTypeTouristState {}

class FilterTypeTouristLoading extends FilterTypeTouristState {}

class FilterTypeTouristLoaded extends FilterTypeTouristState {
  final List<TouristAttractionModel> tourist;
  FilterTypeTouristLoaded({required this.tourist});
  @override
  List<Object?> get props => [tourist];
}

class FilterTypeTouristFailure extends FilterTypeTouristState {
  final String error;
  FilterTypeTouristFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
