import 'package:appquangbadulich/hotel/model/hotelModel.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HotelRepository {
  // String endpoint = 'https://reqres.in/api/user?page=2';
  String endpoint = 'http://192.168.174.214:3090/hotels';

  Future<List<HotelModel>> getHotels() async {
    try {
      Response response = await get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['data'];
        return result.map(((e) => HotelModel.fromJson(e))).toList();
      } else {
        throw Exception('Failed to load hotels: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error while fetching hotels: $e');
      return [];
    }
  }
}
