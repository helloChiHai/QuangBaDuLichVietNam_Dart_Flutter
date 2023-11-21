class AdminModel {
  final String account;
  final String password;

  AdminModel({
    required this.account,
    required this.password,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      account: json['account'],
      password: json['password'],
    );
  }
}
