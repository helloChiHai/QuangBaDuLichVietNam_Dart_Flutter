import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/historyModel.dart';

abstract class HistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<HistoryModel> history;
  HistoryLoaded({required this.history});
  @override
  List<Object?> get props => [history];
}

class HistoryFailure extends HistoryState {
  final String error;
  HistoryFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
