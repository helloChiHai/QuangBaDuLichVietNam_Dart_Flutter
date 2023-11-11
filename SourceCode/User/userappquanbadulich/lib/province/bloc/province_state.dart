import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/provinceModel.dart';

abstract class ProvinceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final List<ProvinceModel> provinces;
  ProvinceLoaded({required this.provinces});
  @override
  List<Object?> get props => [provinces];
}

class ProvinceFailure extends ProvinceState {
  final String error;
  ProvinceFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
