import 'package:appquangbadulich/login/model/ListSaveTouristModel.dart';

class CustomerModel {
  final String idCus;
  final String email;
  final String password;
  final String name;
  final String? imgCus;
  final String address;
  final String birthday;
  final int role;
  final List<ListSaveTouristModel>? listSaveTourist;

  CustomerModel({
    required this.idCus,
    required this.email,
    required this.password,
    required this.name,
    this.imgCus,
    required this.address,
    required this.birthday,
    required this.role,
    this.listSaveTourist,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    List<ListSaveTouristModel> listSaveTourist = [];
    if (json['listSaveTourist'] != null) {
      listSaveTourist = (json['listSaveTourist'] as List)
          .map((listSaveTouristJson) =>
              ListSaveTouristModel.fromJson(listSaveTouristJson))
          .toList();
    }

    return CustomerModel(
      idCus: json["idCus"],
      email: json["email"],
      password: json["password"],
      name: json["name"],
      imgCus: json["imgCus"],
      address: json["address"],
      birthday: json["birthday"],
      role: json["role"],
      listSaveTourist: listSaveTourist,
    );
  }
}
