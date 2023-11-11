import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class DetailTourist_HistoryEvent extends Equatable {
  const DetailTourist_HistoryEvent();
  @override
  List<Object?> get props => [];
}

class getTouristWithHistory extends DetailTourist_HistoryEvent {
  final String idHistoryStory;
  getTouristWithHistory({required this.idHistoryStory});

  @override
  List<Object?> get props => [idHistoryStory];
}
