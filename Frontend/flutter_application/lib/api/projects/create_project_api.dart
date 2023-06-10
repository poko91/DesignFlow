import 'dart:convert';

import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateProjectApi {
  static Future<http.Response> createProject(
      String projectName,
      String projectType,
      String projectStatus,
      String projectAdd,
      String dueDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/projects";
    final uri = Uri.parse(url);
    var data = {
      "project_name": projectName,
      "project_type": projectType,
      "project_status": projectStatus,
      "project_add": projectAdd,
      "due_date": dueDate
    };
    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $accessToken",
        "content-type": "application/json",
      },
      body: json.encode(data),
    );
    return response;
  }
}
