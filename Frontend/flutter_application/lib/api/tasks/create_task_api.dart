import 'dart:convert';

import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateTaskApi {
  static Future<http.Response> createTask(
      String taskTitle,
      String taskDescription,
      String dueDate,
      String priority,
      String projectName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/tasks";
    final uri = Uri.parse(url);
    var data = {
      "task_title": taskTitle,
      "task_description": taskDescription,
      "due_date": dueDate,
      "priority": priority,
      "project_name": projectName
    };
    var response = await http.post(
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
