class CultureModel {
  final String idCulture;
  final String nameCulture;

  CultureModel({
    required this.idCulture,
    required this.nameCulture,
  });

  factory CultureModel.fromJson(Map<String, dynamic> json) {
    return CultureModel(
      idCulture: json['idCulture'],
      nameCulture: json['nameCulture'],
    );
  }
}
