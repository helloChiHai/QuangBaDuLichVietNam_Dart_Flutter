import 'package:equatable/equatable.dart';

abstract class UpdateTouristCultureState extends Equatable {
  const UpdateTouristCultureState();
  @override
  List<Object?> get props => [];
}

class UpdateTouristCultureInitial extends UpdateTouristCultureState {}

class UpdateTouristCultureLoading extends UpdateTouristCultureState {}

class UpdateTouristCultureSuccess extends UpdateTouristCultureState {
  final String success;
  UpdateTouristCultureSuccess({required this.success});
  @override
  List<Object?> get props => [success];
}

class UpdateTouristCultureFailure extends UpdateTouristCultureState {
  final String error;
  UpdateTouristCultureFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
