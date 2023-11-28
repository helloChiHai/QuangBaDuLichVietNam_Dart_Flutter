import 'package:equatable/equatable.dart';

abstract class UpdateTouristIntroState extends Equatable {
  const UpdateTouristIntroState();
  @override
  List<Object?> get props => [];
}

class UpdateTouristIntroInitial extends UpdateTouristIntroState {}

class UpdateTouristIntroLoading extends UpdateTouristIntroState {}

class UpdateTouristIntroSuccess extends UpdateTouristIntroState {
  final String success;
  UpdateTouristIntroSuccess({required this.success});
  @override
  List<Object?> get props => [success];
}

class UpdateTouristIntroFailure extends UpdateTouristIntroState {
  final String error;
  UpdateTouristIntroFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
