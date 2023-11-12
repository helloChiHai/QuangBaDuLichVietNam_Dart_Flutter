import 'package:equatable/equatable.dart';

import '../../model/CustomerModel.dart';

abstract class AddAndRemoveTouristListState extends Equatable {
  @override
  List<Object?> get props => [];
}

// ========== KIỂM TRA ===============
class CheckTouristInListSuccess extends AddAndRemoveTouristListState {
  final bool result;

  CheckTouristInListSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class CheckTouristInListFailure extends AddAndRemoveTouristListState {
  final String error;

  CheckTouristInListFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// ============ THÊM ============
class AddTouristToListInitial extends AddAndRemoveTouristListState {}

class AddTouristToListSuccess extends AddAndRemoveTouristListState {
  final CustomerModel customer;

  AddTouristToListSuccess({required this.customer});

  @override
  List<Object?> get props => [customer];
}

class AddTouristToListFailure extends AddAndRemoveTouristListState {
  final String error;

  AddTouristToListFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

// ============ XÓA ============
class RemoveTouristFromListInitial extends AddAndRemoveTouristListState {}

class RemoveTouristFromListSuccess extends AddAndRemoveTouristListState {
  final CustomerModel customer;

  RemoveTouristFromListSuccess({required this.customer});

  @override
  List<Object?> get props => [customer];
}

class RemoveTouristFromListFailure extends AddAndRemoveTouristListState {
  final String error;

  RemoveTouristFromListFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
