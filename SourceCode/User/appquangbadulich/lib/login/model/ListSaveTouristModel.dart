class ListSaveTouristModel {
  final String idTourist;

  ListSaveTouristModel({required this.idTourist});

  factory ListSaveTouristModel.fromJson(Map<String, dynamic> json) {
    return ListSaveTouristModel(
      idTourist: json['idTourist'],
    );
  }
}
