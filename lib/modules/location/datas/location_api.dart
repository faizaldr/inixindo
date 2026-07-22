import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inixindo/constants/api.dart';
import 'package:inixindo/modules/auth/datas/login_db.dart';
import 'package:inixindo/modules/location/models/location_model.dart';

class LocationApi {
  Future<Map<String, String>> getHeaders() async {
    String? token = await LoginDb().getToken();
    return {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
  }

  Future<LocationModel?> getLocations() async {
    // try {
    final response = await http.get(
      Uri.parse(LOCATION_URL),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return LocationModel.fromJson(responseData);
    }
    return null;
    // }catch(e){
    //   debugPrint(e.toString());
    //   return null;
    // }
  }

  Future<bool> saveLocations({
    String? id,
    required String placeName,
    required String placeType,
    required String comment,
    required double latitude,
    required double longitude,
  }) async {
    // try {
    var body = jsonEncode({
      "data": {
        "placeName": placeName,
        "placeType": placeType,
        "comment": comment,
        "latitude": latitude,
        "longitude": longitude,
      },
    });

    // Tambah Data
    if (id == null) {
      final response = await http.post(
        Uri.parse(LOCATION_URL),
        headers: await getHeaders(),
        body: body,
      );
      return response.statusCode == 200 || response.statusCode == 201;
      //   Ubah data
    } else {
      final response = await http.put(
        Uri.parse(LOCATION_URL + "/$id"),
        headers: await getHeaders(),
        body: body,
      );
      return response.statusCode == 200 || response.statusCode == 201;
    }
    // }catch(e){
    //   debugPrint(e.toString());
    //   return null;
    // }
  }
}
