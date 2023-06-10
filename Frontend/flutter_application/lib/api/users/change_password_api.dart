import 'dart:convert';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PasswordApi {
  static Future<http.Response> changePassword(
      String old_password, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString('access_token');
    var url = "${Utils.baseUrl}/users/editpassword";
    var uri = Uri.parse(url);
    var data = {"old_password": old_password, "password": password};
    var response = await http.post(
      uri,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $access_token",
      },
      body: json.encode(data),
    );
    return response;
  }
}
