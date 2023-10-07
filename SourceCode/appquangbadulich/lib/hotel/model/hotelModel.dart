import 'package:appquangbadulich/hotel/model/kingOfRoomModel.dart';
import 'package:appquangbadulich/hotel/model/serviceModel.dart';

class HotelModel {
  final String idHotel;
  final String nameHotel;
  final String imageHotel;
  final String address;
  final List<ServicesModel> services;
  final double review;
  final int star;
  final List<KingOfRomModel>? kingOfRoom; // Thêm dấu '?' để cho phép giá trị null
  final int statusHotel;

  HotelModel({
    required this.idHotel,
    required this.nameHotel,
    required this.imageHotel,
    required this.address,
    required this.services,
    required this.review,
    required this.star,
    this.kingOfRoom, // Sử dụng '?' ở đây để cho phép giá trị null
    required this.statusHotel,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    // Chuyển đổi danh sách services từ JSON thành danh sách ServicesModel
    List<dynamic> servicesJson = json['services'];
    List<ServicesModel> servicesList = servicesJson
        .map((service) => ServicesModel.fromJson(service))
        .toList();

    // Kiểm tra nếu kingOfRoom là null
    List<KingOfRomModel>? kingOfRoomList;
    if (json['kingOfRoom'] != null) {
      List<dynamic> kingOfRoomJson = json['kingOfRoom'];
      kingOfRoomList = kingOfRoomJson
          .map((kingOfRoom) => KingOfRomModel.fromJson(kingOfRoom))
          .toList();
    }

    return HotelModel(
      idHotel: json['idHotel'],
      nameHotel: json['nameHotel'] ?? 'cuxng k bt nwa',
      imageHotel: json['imageHotel'],
      address: json['address'],
      services: servicesList, // Sử dụng danh sách đã chuyển đổi
      review: json['review'],
      star: json['star'],
      kingOfRoom: kingOfRoomList, // Sử dụng danh sách đã chuyển đổi hoặc null
      statusHotel: json['statusHotel'],
    );
  }
}
