import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class TouristAttractionEvent extends Equatable {
  const TouristAttractionEvent();
  @override
  List<Object?> get props => [];
}

class FetchTouristAttraction extends TouristAttractionEvent {}
