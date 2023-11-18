import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FilterCultureEvent extends Equatable {
  const FilterCultureEvent();
  @override
  List<Object?> get props => [];
}

class FilterCulture extends FilterCultureEvent {
  final String? idRegion;
  final String? idProvines;
  FilterCulture({required this.idRegion, required this.idProvines});
  @override
  List<Object?> get props => [idRegion, idProvines];
}
