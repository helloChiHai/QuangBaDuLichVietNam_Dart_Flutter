class CultureModel {
  final String idCulture;
  final String nameCulture;
  final String? imgCulture;
  final String? videoCulture;

  CultureModel({
    required this.idCulture,
    required this.nameCulture,
    required this.imgCulture,
    required this.videoCulture,
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) {
    return CultureModel(
      idCulture: json['idCulture'],
      nameCulture: json['nameCulture'],
      imgCulture: json['imgCulture'],
      videoCulture: json['videoCulture'],
    );
  }
}
