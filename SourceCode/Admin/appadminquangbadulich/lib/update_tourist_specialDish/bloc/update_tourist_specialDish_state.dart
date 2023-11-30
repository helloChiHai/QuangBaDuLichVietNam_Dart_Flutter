import 'package:equatable/equatable.dart';

abstract class UpdateTouristSpecialDishState extends Equatable {
  const UpdateTouristSpecialDishState();
  @override
  List<Object?> get props => [];
}

class UpdateTouristSpecialDishInitial extends UpdateTouristSpecialDishState {}

class UpdateTouristSpecialDishLoading extends UpdateTouristSpecialDishState {}

class UpdateTouristSpecialDishSuccess extends UpdateTouristSpecialDishState {
  final String success;
  UpdateTouristSpecialDishSuccess({required this.success});
  @override
  List<Object?> get props => [success];
}

class UpdateTouristSpecialDishFailure extends UpdateTouristSpecialDishState {
  final String error;
  UpdateTouristSpecialDishFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
