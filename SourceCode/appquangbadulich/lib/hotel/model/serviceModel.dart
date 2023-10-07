class ServicesModel {
  final String typeServices;
  final String nameServices;

  ServicesModel({required this.typeServices, required this.nameServices});

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      typeServices: json['typeServices'],
      nameServices: json['nameServices'],
    );
  }
}
