import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DetailTourist_AboutEvent extends Equatable {
  const DetailTourist_AboutEvent();
  @override
  List<Object?> get props => [];
}

class getTouristWithIdTourist extends DetailTourist_AboutEvent {
  final String idTourist;
  getTouristWithIdTourist({required this.idTourist});

  @override
  List<Object?> get props => [idTourist];
}
