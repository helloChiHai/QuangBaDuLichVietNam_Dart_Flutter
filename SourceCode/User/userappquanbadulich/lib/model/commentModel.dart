class CommentModel {
  final String idcmt;
  final String idCus;
  final String nameCus;
  final String content;
  final String atTime;

  CommentModel({
    required this.idcmt,
    required this.idCus,
    required this.nameCus,
    required this.content,
    required this.atTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      idcmt: json['idcmt'],
      idCus: json['idCus'],
      nameCus: json['nameCus'],
      content: json['content'],
      atTime: json['atTime'], 
    );
  }
}
