import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class RegionEvent extends Equatable {
  const RegionEvent();

  @override
  List<Object?> get props => [];
}

class FetchRegions extends RegionEvent {}
