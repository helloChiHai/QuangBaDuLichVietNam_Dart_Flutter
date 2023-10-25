class CommentModel {
  final String idcmt;
  final String idCus;
  final String name;
  final String content;
  final String atTime;

  CommentModel({
    required this.idcmt,
    required this.idCus,
    required this.name,
    required this.content,
    required this.atTime,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      idcmt: json['idcmt'],
      idCus: json['idCus'],
      name: json['name'],
      content: json['content'],
      atTime: json['atTime'], 
    );
  }
}
