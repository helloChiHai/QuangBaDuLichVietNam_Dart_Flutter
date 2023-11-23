import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FilterTouristEvent extends Equatable {
  const FilterTouristEvent();
  @override
  List<Object?> get props => [];
}

class FilterTouristAttraction extends FilterTouristEvent {
  final String? idRegion;
  final String? idProvines;
  FilterTouristAttraction({required this.idRegion, required this.idProvines});
  @override
  List<Object?> get props => [idRegion, idProvines];
}
