import 'package:appquangbadulich/model/cultureModel.dart';
import 'package:appquangbadulich/model/commentModel.dart';
import 'package:appquangbadulich/model/historyModel.dart';
import 'package:appquangbadulich/model/specialtyDishModel.dart';

class TouristAttractionModel {
  final List<HistoryModel> history;
  final String idTourist;
  final String nameTourist;
  final String address;
  final String ticket;
  final String? imgTourist;
  final String touristIntroduction;
  final List<String> rightTime;
  final List<CultureModel> culture;
  final List<SpecialtyDishModel> specialtyDish;
  final List<CommentModel> comment;

  TouristAttractionModel({
    required this.history,
    required this.idTourist,
    required this.nameTourist,
    required this.address,
    required this.ticket,
    this.imgTourist,
    required this.touristIntroduction,
    required this.rightTime,
    required this.culture,
    required this.specialtyDish,
    required this.comment,
  });

  factory TouristAttractionModel.fromJson(Map<String, dynamic> json) {
    final rightTimeJson = json['rightTime'];
    final List<String> rightTime = rightTimeJson.cast<String>();

    List<HistoryModel> history = [];
    if (json['history'] != null) {
      history = (json['history'] as List)
          .map((historyJson) => HistoryModel.fromJson(historyJson))
          .toList();
    }

    List<CultureModel> culture = [];
    if (json['culture'] != null) {
      culture = (json['culture'] as List)
          .map((cultureJson) => CultureModel.fromJson(cultureJson))
          .toList();
    }
    List<SpecialtyDishModel> specialtyDish = [];
    if (json['specialtyDish'] != null) {
      specialtyDish = (json['specialtyDish'] as List)
          .map((dishJson) => SpecialtyDishModel.fromJson(dishJson))
          .toList();
    }
    List<CommentModel> comment = [];

    if (json['comment'] != null) {
      comment = (json['comment'] as List)
          .map((commentJson) => CommentModel.fromJson(commentJson))
          .toList();
    }

    return TouristAttractionModel(
      history: history,
      idTourist: json['idTourist'],
      nameTourist: json['nameTourist'],
      address: json['address'],
      ticket: json['ticket'],
      imgTourist: json['imgTourist'],
      touristIntroduction: json['touristIntroduction'],
      rightTime: rightTime,
      culture: culture,
      specialtyDish: specialtyDish,
      comment: comment,
    );
  }
}
