import 'package:equatable/equatable.dart';

abstract class UpdateTouristHistoryEvent extends Equatable {
  const UpdateTouristHistoryEvent();
  @override
  List<Object?> get props => [];
}

class UpdateTouristHistoryButtonPressed extends UpdateTouristHistoryEvent {
  final String idTourist;
  final String idHistoryStory;
  final String titleStoryStory;
  final String contentStoryStory;
  final String? imgHistory;
  UpdateTouristHistoryButtonPressed({
    required this.idTourist,
    required this.idHistoryStory,
    required this.titleStoryStory,
    required this.contentStoryStory,
    required this.imgHistory,
  });
  @override
  List<Object?> get props => [
        idTourist,
        idHistoryStory,
        titleStoryStory,
        contentStoryStory,
        imgHistory,
      ];
}
