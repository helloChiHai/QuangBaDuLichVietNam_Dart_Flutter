import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TotalTouristAttractionEvent extends Equatable {
  const TotalTouristAttractionEvent();
  @override
  List<Object?> get props => [];
}

class ToTalTouristAttraction extends TotalTouristAttractionEvent {}
