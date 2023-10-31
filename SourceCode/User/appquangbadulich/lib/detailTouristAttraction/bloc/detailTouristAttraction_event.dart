import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DetailTouristAcctractionEvent extends Equatable {
  const DetailTouristAcctractionEvent();
  @override
  List<Object?> get props => [];
}

class getTouristWithCulture extends DetailTouristAcctractionEvent {
  final String idCulture;
  getTouristWithCulture({required this.idCulture});

  @override
  List<Object?> get props => [idCulture];
}
