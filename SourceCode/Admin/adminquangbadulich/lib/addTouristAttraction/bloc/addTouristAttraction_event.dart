import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AddTouristAttractionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTouristAttractionButtonPressed extends AddTouristAttractionEvent {
  final String idRegion;
  final String idProvines;
  final String nameTourist;
  final String typeTourist;
  final String address;
  final String ticket;
  final String imgTourist;
  final String touristIntroduction;
  final String rightTime;
  final String titleStoryStory;
  final String contentStoryStory;
  final String avatarHistory;
  final String imgHistory;
  final String videoHistory;
  final String titleCulture;
  final String contentCulture;
  final String imgCulture;
  final String videoCulture;
  final String nameDish;
  final String addressDish;
  final String imgDish;
  final String dishIntroduction;
  final List comment;

  AddTouristAttractionButtonPressed({
    required this.idRegion,
    required this.idProvines,
    required this.nameTourist,
    required this.typeTourist,
    required this.address,
    required this.ticket,
    required this.imgTourist,
    required this.touristIntroduction,
    required this.rightTime,
    required this.titleStoryStory,
    required this.contentStoryStory,
    required this.avatarHistory,
    required this.imgHistory,
    required this.videoHistory,
    required this.titleCulture,
    required this.contentCulture,
    required this.imgCulture,
    required this.videoCulture,
    required this.nameDish,
    required this.addressDish,
    required this.imgDish,
    required this.dishIntroduction,
    required this.comment,
  });

  @override
  List<Object?> get props => [
        idRegion,
        idProvines,
        nameTourist,
        typeTourist,
        address,
        ticket,
        imgTourist,
        touristIntroduction,
        rightTime,
        titleStoryStory,
        contentStoryStory,
        avatarHistory,
        imgHistory,
        videoHistory,
        titleCulture,
        contentCulture,
        imgCulture,
        videoCulture,
        nameDish,
        addressDish,
        imgDish,
        dishIntroduction,
        comment,
      ];
}
