import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthRepository {
  login(String account, String password) async {
    String url = "http://192.168.141.214:3090/auth/login";
    var res = await http.post(
      Uri.parse(url),
      headers: {},
      body: {"account": account, "password": password},
    );
    final data = json.decode(res.body);

    if (data['success'] == true) {
      return data;
    } else {
      return {"error": "auth problem"};
    }
  }

 Future<bool> checkServerConnection() async {
  try {
    final response = await http.get(Uri.parse("http://192.168.141.214:3090/customers"));
    if (response.statusCode == 200) {
      return true; // Kết nối thành công
    } else {
      return false; // Kết nối thất bại
    }
  } catch (e) {
    print("Lỗi khi kiểm tra kết nối máy chủ: $e");
    return false; // Xử lý lỗi và trả về false nếu có lỗi
  }
}

}
