class ProvinceModel {
  final String idprovince;
  final String nameprovince;

  ProvinceModel({required this.idprovince, required this.nameprovince});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      idprovince: json['idprovince'],
      nameprovince: json['nameprovince'],
    );
  }
}
