import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AddAndRemoveTouristListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// ======= THÊM ========
class CheckTouristInList extends AddAndRemoveTouristListEvent {
  final String idCus;
  final String idTourist;

  CheckTouristInList({required this.idCus, required this.idTourist});

  @override
  List<Object?> get props => [idCus, idTourist];
}

// ======= THÊM ========
class AddTouristToListButtonPressed extends AddAndRemoveTouristListEvent {
  final String idCus;
  final String idTourist;

  AddTouristToListButtonPressed({required this.idCus, required this.idTourist});

  @override
  List<Object?> get props => [idCus, idTourist];
}

// ======= XÓA ========
class RemoveTouristFromListButtonPressed extends AddAndRemoveTouristListEvent {
  final String idCus;
  final String idTourist;

  RemoveTouristFromListButtonPressed(
      {required this.idCus, required this.idTourist});

  @override
  List<Object?> get props => [idCus, idTourist];
}
