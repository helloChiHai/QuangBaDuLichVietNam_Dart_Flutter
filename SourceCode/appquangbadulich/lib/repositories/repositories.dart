import 'dart:convert';
import 'package:http/http.dart' as http;

import '../login/model/CustomerModel.dart';

class UserRepository {
  String urlHotel = 'http://192.168.50.214:3090/hotels';
  String urlLogin = 'http://192.168.50.214:3090/login';
  // String urlLogin = 'https://reqres.in/api/login';

  // Future<List<HotelModel>> getHotels() async {
  //   try {
  //     Response response = await get(Uri.parse(urlHotel));
  //     if (response.statusCode == 200) {
  //       final List result = jsonDecode(response.body)['data'];
  //       return result.map(((e) => HotelModel.fromJson(e))).toList();
  //     } else {
  //       throw Exception('Failed to load hotels: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error while fetching hotels: $e');
  //     return [];
  //   }
  // }

  Future<CustomerModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(urlLogin),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        print(data['data']['email']);
        if (data['success'] == true) {
          final idCus = data['data']['idCus'];
          final email = data['data']['email'];
          final password = data['data']['password'];
          final name = data['data']['name'];
          final address = data['data']['address'];
          final birthday = data['data']['birthday'];
          if (idCus != null &&
              name != null &&
              address != null &&
              birthday != null) {
            return CustomerModel(
                idCus: idCus,
                email: email,
                password: password,
                name: name,
                address: address,
                birthday: birthday);
          } else {
            print('không có dữ liệu');
            return null;
          }
        } else {
          print('đang sai gì đó....');
          return null;
        }
      } else {
        throw Exception('Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while logging in: $e');
    }
    return null;
  }
}
