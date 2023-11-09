import 'dart:convert';
import 'package:appquangbadulich/model/cultureModel.dart';
import 'package:appquangbadulich/model/historyModel.dart';
import 'package:appquangbadulich/model/provinceModel.dart';
import 'package:appquangbadulich/model/specialtyDishModel.dart';
import 'package:appquangbadulich/model/touristAttractionModel.dart';
import 'package:http/http.dart' as http;

import '../model/CustomerModel.dart';
import '../model/regionModel.dart';

class UserRepository {
  String urlMain = 'http://192.168.226.214:3090';
  String urlRegion = 'http://192.168.226.214:3090/regions';
  String urlLogin = 'http://192.168.226.214:3090/login';
  String urlGetAllProvinces = 'http://192.168.226.214:3090/getAllProvinces';
  String urlCreateAccount = 'http://192.168.226.214:3090/createAccount';
  String urlgetAllCulture = 'http://192.168.226.214:3090/getAllCulture';
  String urlgetAllHistory = 'http://192.168.226.214:3090/getAllHistory';
  String urlgetAllTouristAttraction =
      'http://192.168.226.214:3090/getAllTouristAttraction';
  String urlgetAllSpecialDish =
      'http://192.168.226.214:3090/getAllSpecialtyDish';

  // UPDATE EMAIL CUSTOMER
  Future<CustomerModel?> updateEmail(String idCus, String newEmail) async {
    final urlUpdate = '$urlMain/updateEmail/$idCus';
    try {
      final response = await http.put(Uri.parse(urlUpdate),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': newEmail}));
      if (response.statusCode == 200) {
        final customerJson = jsonDecode(response.body);
        final customer = CustomerModel.fromJson(customerJson);
        return customer;
      } else {
        throw Exception('Lỗi cập nhật email');
      }
    } catch (e) {
      throw Exception('Lỗi mạng');
    }
  }

  // fetch all tourist attraction
  Future<List<ProvinceModel>> getAllProvinces() async {
    try {
      final response = await http.get(
        Uri.parse(urlGetAllProvinces),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // filter tourist attraction by idRegion, idProvines
  Future<List<TouristAttractionModel>>
      filterTouristAttractionByIdRegionIdProvines(
          String? idRegion, String? idProvines) async {
    try {
      final Map<String, String?> queryParams = {
        'idRegion': idRegion,
        'idProvines': idProvines,
      };

      final uri = Uri.http(
          '192.168.226.214:3090', '/filter-tourist-attractions', queryParams);

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

  // fetch all tourist attraction
  Future<List<TouristAttractionModel>> getAllTouristAttraction() async {
    try {
      final response = await http.get(
        Uri.parse(urlgetAllTouristAttraction),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // detail tourist by idCulture
  Future<TouristAttractionModel?> getDetailTouristWithIdTourist(
      String idTourist) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.226.214:3090/getTouristAttractionByIdTourist/$idTourist'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // fetch tourist by idCulture
  Future<TouristAttractionModel?> getTouristWithCulture(
      String idCulture) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.226.214:3090/getTouristAttractionByIdCulture/$idCulture'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // fetch tourist by idDish
  Future<TouristAttractionModel?> getTouristWithSpecialDish(
      String idDish) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.226.214:3090/getTouristAttractionByIdDish/$idDish'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // fetch tourist by idHistory
  Future<TouristAttractionModel?> getTouristWithHistory(
      String idHistoryStory) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.226.214:3090/getTouristAttractionByidHistoryStory/$idHistoryStory'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // fetch all culture
  Future<List<CultureModel>> getCultures() async {
    try {
      final response = await http.get(
        Uri.parse(urlgetAllCulture),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // FETCH ALL HISTORY
  Future<List<HistoryModel>> getHistory() async {
    try {
      final response = await http.get(
        Uri.parse(urlgetAllHistory),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // fetch all special dish
  Future<List<SpecialtyDishModel>> getSpecialDish() async {
    try {
      final response = await http.get(
        Uri.parse(urlgetAllSpecialDish),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // fetch region
  Future<List<RegionModel>> getRegions() async {
    try {
      final response = await http.get(
        Uri.parse(urlRegion),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
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

  // đăng nhập
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

  // tạo tài khoản
  Future<int> createAccount(String email, String password, String name,
      String? imgCus, String address, String birthday, int role) async {
    try {
      final response = await http.post(
        Uri.parse(urlCreateAccount),
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
