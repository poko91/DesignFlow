import 'dart:convert';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudioNameApi {
  static Future<http.Response> changePassword(String studioName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString('access_token');
    var url = "${Utils.baseUrl}/users/editStudioName";
    var uri = Uri.parse(url);
    var data = {"studio_name": studioName};
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
