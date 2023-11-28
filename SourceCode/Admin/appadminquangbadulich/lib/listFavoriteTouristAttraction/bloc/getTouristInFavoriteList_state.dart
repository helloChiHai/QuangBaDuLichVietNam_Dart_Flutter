import 'package:equatable/equatable.dart';

import '../../model/touristAttractionModel.dart';

abstract class GetTouristInFavoriteListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTouristInFavoriteListInitial extends GetTouristInFavoriteListState {}

class GetTouristInFavoriteListLoading extends GetTouristInFavoriteListState {}

class GetTouristInFavoriteListLoaded extends GetTouristInFavoriteListState {
  final List<TouristAttractionModel> touristAttractions;
  GetTouristInFavoriteListLoaded({required this.touristAttractions});
  @override
  List<Object?> get props => [touristAttractions];
}

class GetTouristInFavoriteListFailure extends GetTouristInFavoriteListState {
  final String error;
  GetTouristInFavoriteListFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
