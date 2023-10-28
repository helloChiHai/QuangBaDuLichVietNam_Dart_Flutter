import 'package:appquangbadulich/region/model/provincesModel.dart';

class RegionModel {
  final String idRegion;
  final String nameRegion;
  final List<ProvincesModel> provinces;

  RegionModel({
    required this.idRegion,
    required this.nameRegion,
    required this.provinces,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? provincesJson = json['provinces'];
    if (provincesJson != null) {
      final List<ProvincesModel> provinces = provincesJson
          .map((provincesData) => ProvincesModel.fromJson(provincesData))
          .toList();
      return RegionModel(
        idRegion: json['idRegion'],
        nameRegion: json['nameRegion'],
        provinces: provinces,
      );
    } else {
      return RegionModel(
        idRegion: json['idRegion'],
        nameRegion: json['nameRegion'],
        provinces: [], 
      );
    }
  }
}