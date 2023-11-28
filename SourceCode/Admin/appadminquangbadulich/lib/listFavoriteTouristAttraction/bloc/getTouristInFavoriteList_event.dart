import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetTouristInFavoriteListEvent extends Equatable {
  const GetTouristInFavoriteListEvent();
  @override
  List<Object?> get props => [];
}

class FetchTouristAttractionInFavoriteList
    extends GetTouristInFavoriteListEvent {
  final String idCus;
  FetchTouristAttractionInFavoriteList({required this.idCus});
  @override
  List<Object?> get props => [idCus];
}
