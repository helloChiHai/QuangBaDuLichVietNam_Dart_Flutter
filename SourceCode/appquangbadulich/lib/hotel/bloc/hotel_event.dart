import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HotelEvent extends Equatable {
  const HotelEvent();
}

class LoadHotelEvent extends HotelEvent{
  @override
  List<Object?> get props => [];
}