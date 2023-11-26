import 'package:equatable/equatable.dart';

abstract class DeleteTouristAttractionEvent extends Equatable {
  const DeleteTouristAttractionEvent();
  @override
  List<Object?> get props => [];
}

class DeleteTouristAttractionButtonPress extends DeleteTouristAttractionEvent {
  final String touristId;
  DeleteTouristAttractionButtonPress({
    required this.touristId,
  });
  @override
  List<Object?> get props => [touristId];
}
