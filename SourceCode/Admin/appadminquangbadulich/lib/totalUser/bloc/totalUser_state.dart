import 'package:equatable/equatable.dart';

abstract class TotalUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TotalUserInitial extends TotalUserState {}

class TotalUserLoading extends TotalUserState {}

class TotalUserLoaded extends TotalUserState {
  final int totalUser;
  TotalUserLoaded({required this.totalUser});
  @override
  List<Object?> get props => [totalUser];
}

class TotalUserFailure extends TotalUserState {
  final String error;
  TotalUserFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
