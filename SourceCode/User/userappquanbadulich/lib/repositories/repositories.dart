import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userappquanbadulich/model/commentModel.dart';
import 'package:userappquanbadulich/model/cultureModel.dart';
import 'package:userappquanbadulich/model/historyModel.dart';
import 'package:userappquanbadulich/model/provinceModel.dart';
import 'package:userappquanbadulich/model/specialtyDishModel.dart';
import 'package:userappquanbadulich/model/touristAttractionModel.dart';

import '../model/CustomerModel.dart';
import '../model/regionModel.dart';

class UserRepository {
  String urlMain = 'http://192.168.88.214:3090';

  // HIỂN THỊ TẤT CẢ BÌNH LUẬN
  Future<List<CommentModel>> getAllCommentByIdTourist(String idTourist) async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/tourist/getComments/$idTourist'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['comments'] is List) {
          final commentList = data['comments'] as List<dynamic>;

          if (commentList.isNotEmpty) {
            final comments = commentList
                .map((commentData) => CommentModel.fromJson(commentData))
                .toList();
            return comments;
          } else {
            return [];
          }
        } else {
          throw Exception('Dữ liệu không phải là một danh sách');
        }
      } else {
        // throw Exception('Lỗi khi lấy bình luận: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy bình luận theo idTourist: $e');
    }
  }

  // HIỂN THỊ TẤT CẢ CÁC ĐỊA ĐIỂM DU LỊCH TRONG DANH SÁCH ĐỊA ĐIỂM YÊU THÍCH
  Future<List<TouristAttractionModel>> getTouristInFavoritelistByIdCus(
      String idCus) async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getTouristInFavoriteList/$idCus'),
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
            'Lỗi khi lấy địa điểm du lịch trong danh sách yêu thích ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(
          'Lỗi khi lấy địa điểm du lịch trong danh sách yêu thích theo idCus: $e');
    }
  }

  // KIỂM TRA TOURIST VÀO DANH SÁCH YÊU THÍCH
  Future<bool> checkTouristAttractionInFavouriteList(
      String idCus, String idTourist) async {
    final urlcheckTouristFromFavouriteList =
        '$urlMain/check-tourist/$idCus/$idTourist';
    try {
      final response = await http.get(
        Uri.parse(urlcheckTouristFromFavouriteList),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['isTouristSaved'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // XÓA TOURIST VÀO DANH SÁCH YÊU THÍCH
  Future<CustomerModel> removeTouristAttractionFromFavouriteList(
      String idCus, String idTourist) async {
    final urlRemoveTouristFromFavouriteList =
        '$urlMain/removeTourist/$idCus/$idTourist';
    try {
      final response = await http.delete(
        Uri.parse(urlRemoveTouristFromFavouriteList),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi xóa địa điểm: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // THÊM TOURIST VÀO DANH SÁCH YÊU THÍCH
  Future<CustomerModel> addTouristAttractionToFavouriteList(
      String idCus, String idTourist) async {
    final urlAddTouristToFavouriteList =
        '$urlMain/addTourist/$idCus/$idTourist';
    try {
      final response = await http.post(
        Uri.parse(urlAddTouristToFavouriteList),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi thêm địa điểm: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // XÓA TÀI KHOẢN
  Future<int> deleteAccount(String idCus) async {
    final urlUpdate = '$urlMain/deleteCustomer/$idCus';
    try {
      final response = await http.delete(
        Uri.parse(urlUpdate),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        throw Exception('Lỗi xóa tài khoản: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // CẬP NHẬT HÌNH ẢNH
  Future<CustomerModel?> updateImage(String idCus, String newImage) async {
    final urlUpdate = '$urlMain/updateImage/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'imgCus': newImage}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi cập nhật img: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // CẬP NHẬT EMAIL
  Future<CustomerModel?> updateEmail(String idCus, String newEmail) async {
    final urlUpdate = '$urlMain/updateEmail/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': newEmail}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi cập nhật email: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // CẬP NHẬT TÊN
  Future<CustomerModel?> updateName(String idCus, String newName) async {
    final urlUpdate = '$urlMain/updateName/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'name': newName}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi cập nhật name: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // CẬP NHẬT ĐỊA CHỈ
  Future<CustomerModel?> updateAddress(String idCus, String newAddress) async {
    final urlUpdate = '$urlMain/updateAddress/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'address': newAddress}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi cập nhật address: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // CẬP NHẬT NGÀY SINH
  Future<CustomerModel?> updateBirthday(
      String idCus, String newBirthday) async {
    final urlUpdate = '$urlMain/updateBirthday/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'birthday': newBirthday}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi cập nhật birthday: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // CẬP NHẬT MẬT KHẨU
  Future<CustomerModel?> updatePassword(
      String idCus, String newPassword) async {
    final urlUpdate = '$urlMain/updatePassword/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'password': newPassword}));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final customermodel = CustomerModel.fromJson(data['data']);
        return customermodel;
      } else {
        throw Exception('Lỗi cập nhật PASSWORD: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // LẤY TẤT CẢ CÁC TỈNH THÀNH PHỐ
  Future<List<ProvinceModel>> getAllProvinces() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getAllProvinces'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final provinceList = data['data'] as List<dynamic>;
        final province = provinceList
            .map((provinceData) => ProvinceModel.fromJson(provinceData))
            .toList();
        return province;
      } else {
        throw Exception('Failed to fetch province: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching province: $e');
      throw Exception('Error while fetching province: $e');
    }
  }

  // LỌC ĐỊA ĐIỂM THEO idRegion, idProvines
  Future<List<TouristAttractionModel>>
      filterTouristAttractionByIdRegionIdProvines(
          String? idRegion, String? idProvines) async {
    try {
      final Map<String, String?> queryParams = {
        'idRegion': idRegion,
        'idProvines': idProvines,
      };

      final uri =
          Uri.http('$urlMain', '/filter-tourist-attractions', queryParams);

      // final uri = Uri.http(
      //     '192.168.226.214:3090', '/filter-tourist-attractions', queryParams);

      final response = await http.get(
        uri,
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
            'Lỗi khi lấy thông tin Tourist Attraction: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
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

  // HIỂN THỊ TẤT CẢ VĂN HÓA
  Future<List<CultureModel>> getCultures() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getAllCulture'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final cultureList = data['data'] as List<dynamic>;
        final cultures = cultureList
            .map((cultureData) => CultureModel.fromJson(cultureData))
            .toList();
        return cultures;
      } else {
        throw Exception('Failed to fetch culture: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching culture: $e');
      throw Exception('Error while fetching culture: $e');
    }
  }

  // HIỂN THỊ TẤT CẢ LỊCH SỬ
  Future<List<HistoryModel>> getHistory() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getAllHistory'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final historyList = data['data'] as List<dynamic>;
        final history_ = historyList
            .map((historyData) => HistoryModel.fromJson(historyData))
            .toList();
        return history_;
      } else {
        throw Exception('Failed to fetch history: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching history: $e');
      throw Exception('Error while fetching history: $e');
    }
  }

  // HIỂN THỊ TẤT CẢ CÁC MÓN ĂN
  Future<List<SpecialtyDishModel>> getSpecialDish() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/getAllSpecialtyDish'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final specialDishList = data['data'] as List<dynamic>;
        final specialDishs = specialDishList
            .map((specialDishData) =>
                SpecialtyDishModel.fromJson(specialDishData))
            .toList();
        return specialDishs;
      } else {
        throw Exception(
            'Failed to fetch special dish: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching specialdish: $e');
      throw Exception('Error while fetching specialdish: $e');
    }
  }

  // HIỂN THỊ KHU VỰC
  Future<List<RegionModel>> getRegions() async {
    try {
      final response = await http.get(
        Uri.parse('$urlMain/regions'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final regionList = data['data'] as List<dynamic>;
        final regions = regionList
            .map((regionData) => RegionModel.fromJson(regionData))
            .toList();
        return regions;
      } else {
        throw Exception('Failed to fetch regions: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching regions: $e');
      throw Exception('Error while fetching regions: $e');
    }
  }

  // ĐĂNG NHẬP
  Future<CustomerModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$urlMain/login'),
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
          final imgCus = data['data']['imgCus'];
          final address = data['data']['address'];
          final birthday = data['data']['birthday'];
          final role = data['data']['role'];
          if (idCus != null &&
              name != null &&
              address != null &&
              birthday != null) {
            return CustomerModel(
                idCus: idCus,
                email: email,
                password: password,
                name: name,
                imgCus: imgCus,
                address: address,
                birthday: birthday,
                role: role);
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

  // TẠO TÀI KHOẢN
  Future<int> createAccount(String email, String password, String name,
      String? imgCus, String? address, String? birthday, int role) async {
    try {
      final response = await http.post(
        Uri.parse('$urlMain/createAccount'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "name": name,
          "imgCus": imgCus,
          "address": address,
          "birthday": birthday,
          "role": role,
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
