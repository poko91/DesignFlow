import 'dart:convert';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<http.Response> login(String email, String password) async {
    var url = "${Utils.baseUrl}/auth/login";
    var uri = Uri.parse(url);
    var data = {
      "email": email,
      "password": password,
    };

    var response = await http.post(
      uri,
      headers: {"content-type": "application/json"},
      body: json.encode(data),
    );
    return response;
}

   static Future<http.Response> register(String studioName, String email, String password) async {
    var url = "${Utils.baseUrl}/auth/register";
    var uri = Uri.parse(url);
    var data = {
      "studio_name": studioName,
      "email": email,
      "password": password,
    };

    var response = await http.post(
      uri,
      headers: {"content-type": "application/json"},
      body: json.encode(data),
    );
    return response;
}

static Future<http.Response> logout(String? refresh_token) async {
    var url = "${Utils.baseUrl}/auth/logout";
    var uri = Uri.parse(url);
    var data = {
      "refresh_token": refresh_token,
    };

    var response = await http.post(
      uri,
      headers: {"content-type": "application/json"},
      body: json.encode(data),
    );
    return response;
}
}