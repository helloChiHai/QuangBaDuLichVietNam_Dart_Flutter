import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class FilterHistoryEvent extends Equatable {
  const FilterHistoryEvent();
  @override
  List<Object?> get props => [];
}

class FilterHistory extends FilterHistoryEvent {
  final String? idRegion;
  final String? idProvines;
  FilterHistory({required this.idRegion, required this.idProvines});
  @override
  List<Object?> get props => [idRegion, idProvines];
}
