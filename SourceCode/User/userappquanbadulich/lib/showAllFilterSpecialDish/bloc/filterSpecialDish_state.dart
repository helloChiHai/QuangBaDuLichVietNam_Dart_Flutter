import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/specialtyDishModel.dart';

abstract class FilterSpecialDishState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterSpecialDishInitial extends FilterSpecialDishState {}

class FilterSpecialDishLoading extends FilterSpecialDishState {}

class FilterSpecialDishLoaded extends FilterSpecialDishState {
  final List<SpecialtyDishModel> specialDish;
  FilterSpecialDishLoaded({required this.specialDish});
  @override
  List<Object?> get props => [specialDish];
}

class FilterSpecialDishFailure extends FilterSpecialDishState {
  final String error;
  FilterSpecialDishFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
