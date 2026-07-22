import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inixindo/constants/api.dart';
import 'package:inixindo/modules/auth/datas/login_db.dart';
import 'package:inixindo/modules/location/models/location_model.dart';

class LocationApi {
  Future<Map<String,String>> getHeaders() async {
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
}
