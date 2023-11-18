import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/cultureModel.dart';

abstract class FilterCultureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterCultureInitial extends FilterCultureState {}

class FilterCultureLoading extends FilterCultureState {}

class FilterCultureLoaded extends FilterCultureState {
  final List<CultureModel> culture;
  FilterCultureLoaded({required this.culture});
  @override
  List<Object?> get props => [culture];
}

class FilterCultureFailure extends FilterCultureState {
  final String error;
  FilterCultureFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
