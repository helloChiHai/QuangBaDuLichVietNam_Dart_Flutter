import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FilterSpecialDishEvent extends Equatable {
  const FilterSpecialDishEvent();
  @override
  List<Object?> get props => [];
}

class FilterSpecialDish extends FilterSpecialDishEvent {
  final String? idRegion;
  final String? idProvines;
  FilterSpecialDish({required this.idRegion, required this.idProvines});
  @override
  List<Object?> get props => [idRegion, idProvines];
}
