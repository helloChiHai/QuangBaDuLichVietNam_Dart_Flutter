class CultureModel {
  final String idCulture;
  final String titleCulture;
  final String contentCulture;
  final String? imgCulture;
  final String? videoCulture;

  CultureModel({
    required this.idCulture,
    required this.titleCulture,
    required this.contentCulture,
    required this.imgCulture,
    required this.videoCulture,
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) {
    return CultureModel(
      idCulture: json['idCulture'],
      titleCulture: json['titleCulture'],
      contentCulture: json['contentCulture'],
      imgCulture: json['imgCulture'],
      videoCulture: json['videoCulture'],
    );
  }
}
