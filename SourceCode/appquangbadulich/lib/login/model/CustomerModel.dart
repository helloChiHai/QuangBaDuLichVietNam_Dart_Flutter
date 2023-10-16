class CustomerModel {
  final String idCus;
  final String email;
  final String password;
  final String name;
  final String address;
  final String birthday;

  CustomerModel({
    required this.idCus,
    required this.email,
    required this.password,
    required this.name,
    required this.address,
    required this.birthday,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      idCus: json["idCus"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      address: json["address"],
      birthday: json["birthday"],
    );
  }

}
