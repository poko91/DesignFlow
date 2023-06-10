import 'dart:convert';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApi {
  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    var url = "${Utils.baseUrl}/users";
    var uri = Uri.parse(url);

    var response = await http.post(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch user');
    }
  }
}
