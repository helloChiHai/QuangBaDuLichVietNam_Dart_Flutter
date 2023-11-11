import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/specialtyDishModel.dart';

abstract class SpecialDishState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SpecialDishInitial extends SpecialDishState {}

class SpecialDishLoading extends SpecialDishState {}

class SpecialDishLoaded extends SpecialDishState {
  final List<SpecialtyDishModel> specialDishs;
  SpecialDishLoaded({required this.specialDishs});
  @override
  List<Object?> get props => [specialDishs];
}

class SpecialDishFailure extends SpecialDishState {
  final String error;
  SpecialDishFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
