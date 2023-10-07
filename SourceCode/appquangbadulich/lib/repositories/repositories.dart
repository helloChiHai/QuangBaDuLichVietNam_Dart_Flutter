import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static String mainUrl = "http://192.168.174.214:3090";
  var loginUrl = '$mainUrl/login';
  var hotelUrl = '$mainUrl/hotels';

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

  Future<List<dynamic>> getHotels() async {
    try {
      Response response = await dio.get(hotelUrl);
      if (response.statusCode == 200) {
        return response.data["data"];
      } else {
        throw Exception('Failed to load hotels');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
