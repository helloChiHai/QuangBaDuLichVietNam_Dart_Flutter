import 'package:equatable/equatable.dart';

import '../../model/CustomerModel.dart';

abstract class UpdateImageState extends Equatable {
  const UpdateImageState();
  @override
  List<Object?> get props => [];
}

class UpdateImageInitial extends UpdateImageState {}

class UpdateImageLoading extends UpdateImageState {}

class UpdateImageSuccess extends UpdateImageState {
  final CustomerModel customer;
  UpdateImageSuccess({required this.customer});
  @override
  List<Object?> get props => [customer];
}

class UpdateImageFailure extends UpdateImageState {
  final String error;
  UpdateImageFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
