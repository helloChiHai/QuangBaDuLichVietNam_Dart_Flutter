import 'package:equatable/equatable.dart';

import '../../model/regionModel.dart';

abstract class RegionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegionInitial extends RegionState {}

class RegionLoading extends RegionState {}

class RegionLoaded extends RegionState {
  final List<RegionModel> regions;
  RegionLoaded({required this.regions});
  @override
  List<Object?> get props => [regions];
}

class RegionLoadFailure extends RegionState {
  final String error;
  RegionLoadFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
