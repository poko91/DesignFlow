import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountApi {
  static Future<http.Response> deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.getString('access_token');
    var url = "${Utils.baseUrl}/users/deleteprofile";
    var uri = Uri.parse(url);
    var response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $access_token",
      },
    );
    return response;
  }
}
