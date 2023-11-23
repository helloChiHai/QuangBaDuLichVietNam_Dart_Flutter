class SpecialtyDishModel {
  final String idDish;
  final String nameDish;
  final String addressDish;
  final String? imgDish;
  final String dishIntroduction;

  SpecialtyDishModel({
    required this.idDish,
    required this.nameDish,
    required this.addressDish,
    required this.imgDish,
    required this.dishIntroduction,
  });

  factory SpecialtyDishModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyDishModel(
      idDish: json['idDish'],
      nameDish: json['nameDish'],
      addressDish: json['addressDish'],
      imgDish: json['imgDish'],
      dishIntroduction: json['dishIntroduction'],
    );
  }
}
