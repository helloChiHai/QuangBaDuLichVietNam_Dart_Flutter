import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  // static String mainUrl = "http://192.168.141.214:3090";
  // static String mainUrl = "https://reqres.in";
  var loginUrl = 'http://192.168.174.214:3090/login';
  // var loginUrl = '$mainUrl/auth/login';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persisToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String email, String password) async {
    Response response = await dio.post(loginUrl, data: {
      "email": email,
      "password": password,
    });
    return response.data["token"];
  }
}
