import 'package:appquangbadulich/hotel/model/hotelModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HotelState extends Equatable {}

class HotelLoadingState extends HotelState {
  @override
  List<Object?> get props => [];
}

class HotelLoadedState extends HotelState {
  final List<HotelModel> hotels;
  HotelLoadedState(this.hotels);
  @override
  List<Object?> get props => [hotels];
}

class HotelErrorState extends HotelState {
  HotelErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}

