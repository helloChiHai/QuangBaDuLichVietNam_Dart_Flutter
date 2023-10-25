import 'package:appquangbadulich/region/model/touristAttractionModel.dart';

class ProvincesModel {
  final String idProvines;
  final String nameProvines;
  final List<TouristAttractionModel>? touristAttraction; 

  ProvincesModel({
    required this.idProvines,
    required this.nameProvines,
    this.touristAttraction,
  });

  factory ProvincesModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> touristAttractionJson = json['touristAttraction'];
    final List<TouristAttractionModel> touristAttraction = touristAttractionJson
        .map((touristAttractionData) =>
            TouristAttractionModel.fromJson(touristAttractionData))
        .toList();

    return ProvincesModel(
      idProvines: json['idProvines'],
      nameProvines: json['nameProvines'],
      touristAttraction: touristAttraction,
    );
  }
}
