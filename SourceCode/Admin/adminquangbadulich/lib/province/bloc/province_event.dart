import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProvinceEvent extends Equatable {
  const ProvinceEvent();
  @override
  List<Object?> get props => [];
}

class FetchProvinces extends ProvinceEvent {}
