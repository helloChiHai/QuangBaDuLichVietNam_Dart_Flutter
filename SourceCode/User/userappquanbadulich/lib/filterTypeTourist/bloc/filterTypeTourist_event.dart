import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FilterTypeTouristEvent extends Equatable {
  const FilterTypeTouristEvent();
  @override
  List<Object?> get props => [];
}

class FilterTypeTouristAttraction extends FilterTypeTouristEvent {
  final String typeTourist;
  FilterTypeTouristAttraction({required this.typeTourist});
  @override
  List<Object?> get props => [typeTourist];
}
