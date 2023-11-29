import 'package:equatable/equatable.dart';

abstract class UpdateTouristHistoryState extends Equatable {
  const UpdateTouristHistoryState();
  @override
  List<Object?> get props => [];
}

class UpdateTouristHistoryInitial extends UpdateTouristHistoryState {}

class UpdateTouristHistoryLoading extends UpdateTouristHistoryState {}

class UpdateTouristHistorySuccess extends UpdateTouristHistoryState {
  final String success;
  UpdateTouristHistorySuccess({required this.success});
  @override
  List<Object?> get props => [success];
}

class UpdateTouristHistoryFailure extends UpdateTouristHistoryState {
  final String error;
  UpdateTouristHistoryFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
