import 'package:equatable/equatable.dart';

import '../../model/CustomerModel.dart';

abstract class UpdateNameState extends Equatable {
  const UpdateNameState();
  @override
  List<Object?> get props => [];
}

class UpdateNameInitial extends UpdateNameState {}

class UpdateNameLoading extends UpdateNameState {}

class UpdateNameSuccess extends UpdateNameState {
  final CustomerModel customer;
  UpdateNameSuccess({required this.customer});
  @override
  List<Object?> get props => [customer];
}

class UpdateNameFailure extends UpdateNameState {
  final String error;
  UpdateNameFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
