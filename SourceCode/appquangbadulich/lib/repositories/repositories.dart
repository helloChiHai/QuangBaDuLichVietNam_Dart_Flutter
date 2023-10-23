import 'dart:convert';
import 'package:http/http.dart' as http;

import '../login/model/CustomerModel.dart';

class UserRepository {
  String urlHotel = 'http://192.168.8.214:3090/hotels';
  String urlLogin = 'http://192.168.8.214:3090/login';
  String urlCreateAccount = 'http://192.168.8.214:3090/createAccount';

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

  Future<int> createAccount(String email, String password, String name,
      String address, String birthday) async {
    try {
      final response = await http.post(
        Uri.parse(urlCreateAccount),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "name": name,
          "address": address,
          "birthday": birthday,
        }),
      );
      if (response.statusCode == 201) {
        return 1; // tạo tài khoản thành công
      } else if (response.statusCode == 409) {
        return -1; // email đã tồn tại
      } else {
        return 0; // tạo tài khoản thất bại
      }
    } catch (e) {
      print('lỗi trong quá trình tạo tài khoản: $e');
      return 2; // lỗi trong quá trình tạo tài khoản
    }
  }
}
