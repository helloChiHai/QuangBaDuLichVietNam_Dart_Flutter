import 'package:equatable/equatable.dart';
import 'package:userappquanbadulich/model/historyModel.dart';

abstract class FilterHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterHistoryInitial extends FilterHistoryState {}

class FilterHistoryLoading extends FilterHistoryState {}

class FilterHistoryLoaded extends FilterHistoryState {
  final List<HistoryModel> history;
  FilterHistoryLoaded({required this.history});
  @override
  List<Object?> get props => [history];
}

class FilterHistoryFailure extends FilterHistoryState {
  final String error;
  FilterHistoryFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
