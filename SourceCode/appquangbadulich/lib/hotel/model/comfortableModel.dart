class ComfortableModel {
  final String iconComfortable;
  final String nameComfortable;

  ComfortableModel(
      {required this.iconComfortable, required this.nameComfortable});

  factory ComfortableModel.fromJson(Map<String, dynamic> json) {
    return ComfortableModel(
      iconComfortable: json['iconComfortable'],
      nameComfortable: json['nameComfortable'],
    );
  }
}
