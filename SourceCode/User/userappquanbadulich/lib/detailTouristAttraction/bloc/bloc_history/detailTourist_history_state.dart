import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

abstract class DetailTourist_HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailTourist_HistoryInitial extends DetailTourist_HistoryState {}

class DetailTourist_HistoryLoading extends DetailTourist_HistoryState {}

class DetailTourist_HistoryLoaded extends DetailTourist_HistoryState {
  final TouristAttractionModel? touristAttraction;
  DetailTourist_HistoryLoaded({required this.touristAttraction});
  @override
  List<Object?> get props => [touristAttraction];
}

class DetailTourist_HistoryFailure extends DetailTourist_HistoryState {
  final String error;
  DetailTourist_HistoryFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
