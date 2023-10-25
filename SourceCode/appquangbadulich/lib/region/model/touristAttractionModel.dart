class TouristAttractionModel {
  final String idTourist;
  final String nameTourist;
  TouristAttractionModel({
    required this.idTourist,
    required this.nameTourist,
  });

  factory TouristAttractionModel.fromJson(Map<String, dynamic> json) {
    return TouristAttractionModel(
      idTourist: json['idTourist'],
      nameTourist: json['nameTourist'],
    );
  }
}
// import 'package:appquangbadulich/region/model/commentModel.dart';
// import 'package:appquangbadulich/region/model/cultureModel.dart';
// import 'package:appquangbadulich/region/model/historyModel.dart';
// import 'package:appquangbadulich/region/model/specialtyDishModel.dart';

// class TouristAttractionModel {
//   final List<HistoryModel>? history;
//   final String idTourist;
//   final String nameTourist;
//   final String address;
//   final String ticket;
//   final String? imgTourist;
//   final String touristIntroduction;
//   final List<String>? rightTime;
//   final List<CultureModel>? culture;
//   final List<SpecialtyDishModel>? specialtyDish;
//   final List<CommentModel>? comment;

//   TouristAttractionModel({
//     this.history,
//     required this.idTourist,
//     required this.nameTourist,
//     required this.address,
//     required this.ticket,
//     required this.imgTourist,
//     required this.touristIntroduction,
//     this.rightTime,
//     this.culture,
//     this.specialtyDish,
//     this.comment,
//   });

//   factory TouristAttractionModel.fromJson(Map<String, dynamic> json) {
//     final List<dynamic> historyJson = json['history'];
//     final List<HistoryModel> history = historyJson
//         .map((historyData) => HistoryModel.fromJson(historyData))
//         .toList();

//     final List<dynamic> cultureJson = json['culture'];
//     final List<CultureModel> culture = cultureJson
//         .map((cultureData) => CultureModel.fromJson(cultureData))
//         .toList();

//     final List<dynamic> specialtyDishJson = json['specialtyDish'];
//     final List<SpecialtyDishModel> specialtyDish = specialtyDishJson
//         .map((specialtyDishData) =>
//             SpecialtyDishModel.fromJson(specialtyDishData))
//         .toList();

//     final List<dynamic> commentJson = json['comment'];
//     final List<CommentModel> comment = commentJson
//         .map((commentData) => CommentModel.fromJson(commentData))
//         .toList();

//     final List<dynamic>? rightTimeJson = json['rightTime'];
//     final List<String>? rightTime =
//         rightTimeJson?.map((dynamic e) => e.toString())?.toList();

//     return TouristAttractionModel(
//       idTourist: json['idTourist'],
//       nameTourist: json['nameTourist'],
//       address: json['address'],
//       ticket: json['ticket'],
//       imgTourist: json['imgTourist'],
//       touristIntroduction: json['touristIntroduction'],
//       rightTime: rightTime,
//       history: history,
//       culture: culture,
//       specialtyDish: specialtyDish,
//       comment: comment,
//     );
//   }
// }
