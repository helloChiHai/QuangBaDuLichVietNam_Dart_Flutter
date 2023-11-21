import 'dart:convert';

import 'package:appadminquangbadulich/model/adminModel.dart';
import 'package:appadminquangbadulich/model/commentModel.dart';
import 'package:appadminquangbadulich/model/touristAttractionModel.dart';
import 'package:http/http.dart' as http;

class AdminRepository {
  String urlMain = 'http://192.168.243.214:3090';

  // HIỂN THỊ TẤT CẢ BÌNH LUẬN
  Future<List<CommentModel>> getAllCommentByIdTourist(String idTourist) async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/tourist/getComments/$idTourist'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final commentList = data['data'] as List<dynamic>;
        final comments = commentList
            .map((cmtData) => CommentModel.fromJson(cmtData))
            .toList();
        return comments;
      } else {
        throw Exception(
            'Failed to fetch special dish: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy bình luận theo idTourist: $e');
    }
  }

  // CHI TIẾT ĐỊA ĐIỂM THEO idCulture
  Future<TouristAttractionModel?> getDetailTouristWithIdTourist(
      String idTourist) async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getTouristAttractionByIdTourist/$idTourist'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final touristAcctractionModel =
            TouristAttractionModel.fromJson(data['data']);
        return touristAcctractionModel;
      } else {
        throw Exception(
            'Lỗi khi lấy tỉnh/ thành phố chw Tourist ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Lỗi khi lấy tỉnh/ thành phố chứa Tourist theo idTourist: $e');
    }
  }

  // HIỂN THỊ ĐỊA ĐIỂM DU LỊCH THEO idDish
  Future<TouristAttractionModel?> getTouristWithSpecialDish(
      String idDish) async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getTouristAttractionByIdDish/$idDish'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final touristAcctractionModel =
            TouristAttractionModel.fromJson(data['data']);
        return touristAcctractionModel;
      } else {
        throw Exception(
            'Lỗi khi lấy tỉnh/ thành phố chw specialDish ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Lỗi khi lấy tỉnh/ thành phố chứa specialDish theo isDish: $e');
    }
  }

  // HIỂN THỊ ĐIỂM DU LỊCH THEO idHistory
  Future<TouristAttractionModel?> getTouristWithHistory(
      String idHistoryStory) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$urlMain/getTouristAttractionByidHistoryStory/$idHistoryStory'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final touristAcctractionModel =
            TouristAttractionModel.fromJson(data['data']);
        return touristAcctractionModel;
      } else {
        throw Exception(
            'Lỗi khi lấy tỉnh/ thành phố chw history ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Lỗi khi lấy tỉnh/ thành phố chứa history theo idHistory: $e');
    }
  }

  // HIỂN THỊ ĐỊA ĐIỂM DU LỊCH THEO idCulture
  Future<TouristAttractionModel?> getTouristWithCulture(
      String idCulture) async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getTouristAttractionByIdCulture/$idCulture'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final touristAcctractionModel =
            TouristAttractionModel.fromJson(data['data']);
        return touristAcctractionModel;
      } else {
        throw Exception(
            'Lỗi khi lấy tỉnh/ thành phố chw culture ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Lỗi khi lấy tỉnh/ thành phố chứa Culture theo idCulture: $e');
    }
  }

  // HIỂN THỊ TẤT CẢ CÁC ĐỊA ĐIỂM DU LỊCH
  Future<List<TouristAttractionModel>> getAllTouristAttraction() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getAllTouristAttraction'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final touristList = data['data'] as List<dynamic>;
        final touristAttractions = touristList
            .map((touristData) => TouristAttractionModel.fromJson(touristData))
            .toList();
        return touristAttractions;
      } else {
        throw Exception(
            'Failed to fetch tourist attraction: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching tourist attraction: $e');
      throw Exception('Error while fetching tourist attraction: $e');
    }
  }

  // TỔNG ĐỊA ĐIỂM DU LỊCH
  Future<int> totalTouristAttraction() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/totalTouristAttraction'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
       final totalTourist = data['data'];
return totalTourist;

      } else {
        throw Exception(
            'Failed to fetch tourist attraction: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching tourist attraction: $e');
      throw Exception('Error while fetching tourist attraction: $e');
    }
  }

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
