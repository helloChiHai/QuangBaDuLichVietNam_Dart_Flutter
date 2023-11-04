import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class SpecialDishEvent extends Equatable {
  const SpecialDishEvent();
  @override
  List<Object?> get props => [];
}

class FetchSpecialDish extends SpecialDishEvent {}
