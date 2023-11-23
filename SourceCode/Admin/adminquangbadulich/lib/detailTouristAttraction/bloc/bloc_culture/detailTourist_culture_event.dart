import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DetailTourist_CultureEvent extends Equatable {
  const DetailTourist_CultureEvent();
  @override
  List<Object?> get props => [];
}

class getTouristWithCulture extends DetailTourist_CultureEvent {
  final String idCulture;
  getTouristWithCulture({required this.idCulture});

  @override
  List<Object?> get props => [idCulture];
}
