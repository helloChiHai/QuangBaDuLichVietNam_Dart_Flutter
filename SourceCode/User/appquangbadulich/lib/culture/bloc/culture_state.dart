import 'package:appquangbadulich/culture/model/cultureModel.dart';
import 'package:equatable/equatable.dart';

abstract class CultureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CultureInitial extends CultureState {}

class CultureLoading extends CultureState {}

class CultureLoaded extends CultureState {
  final List<CultureModel> cultures;
  CultureLoaded({required this.cultures});
  @override
  List<Object?> get props => [cultures];
}

class CultureFailure extends CultureState {
  final String error;
  CultureFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
