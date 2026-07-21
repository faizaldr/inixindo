import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inixindo/constants/api.dart';
import 'package:inixindo/modules/auth/models/auth_model.dart';

class LoginApi {
  Future<AuthModel?> login(String identifier, String password) async {
    // try {
      final response = await http.post(
        Uri.parse(LOGIN_URL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"identifier": identifier, "password": password}),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AuthModel.fromJson(responseData);
      }
      return null;
    // }catch(e){
    //   debugPrint(e.toString());
    //   return null;
    // }
  }
}
