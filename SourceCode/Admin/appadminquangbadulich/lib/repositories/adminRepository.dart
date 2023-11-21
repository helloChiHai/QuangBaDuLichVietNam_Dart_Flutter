import 'dart:convert';

import 'package:appadminquangbadulich/model/adminModel.dart';
import 'package:http/http.dart' as http;

class AdminRepository {
  String urlMain = 'http://192.168.243.214:3090';

  // ADMIN ĐĂNG NHẬP
  Future<AdminModel?> loginAdmin(String account, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$urlMain/loginAdmin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"account": account, "password": password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final account = data['data']['account'];
          final password = data['data']['password'];
          if (account != null && password != null) {
            return AdminModel(
              account: account,
              password: password,
            );
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
