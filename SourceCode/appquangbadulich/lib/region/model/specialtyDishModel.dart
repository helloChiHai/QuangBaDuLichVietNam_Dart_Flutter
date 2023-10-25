class SpecialtyDishModel {
  final String idDish;
  final String nameDish;
  final String? imgDish;
  final String dishIntroduction;

  SpecialtyDishModel({
    required this.idDish,
    required this.nameDish,
    required this.imgDish,
    required this.dishIntroduction,
  });

  factory SpecialtyDishModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyDishModel(
      idDish: json['idDish'],
      nameDish: json['nameDish'],
      imgDish: json['imgDish'],
      dishIntroduction: json['dishIntroduction'],
    );
  }
}
