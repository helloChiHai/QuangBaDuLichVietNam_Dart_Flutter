import 'package:appquangbadulich/hotel/model/comfortableModel.dart';

class KingOfRomModel {
  final String idRoom;
  final int typeRoom;
  final int quantity;
  final int bed;
  final double price;
  final List<ComfortableModel> comfortable;
  final DateTime bookingDate;
  final DateTime checkOutDate;
  final int statusRoom;

  KingOfRomModel({
    required this.idRoom,
    required this.typeRoom,
    required this.quantity,
    required this.bed,
    required this.price,
    required this.comfortable,
    required this.bookingDate,
    required this.checkOutDate,
    required this.statusRoom,
  });

  factory KingOfRomModel.fromJson(Map<String, dynamic> json) {
    return KingOfRomModel(
      idRoom: json['idRoom'],
      typeRoom: json['typeRoom'],
      quantity: json['quantity'],
      bed: json['bed'],
      price: json['price'],
      comfortable: json['comfortable'],
      bookingDate: json['bookingDate'],
      checkOutDate: json['checkOutDate'],
      statusRoom: json['statusRoom'],
    );
  }
}
