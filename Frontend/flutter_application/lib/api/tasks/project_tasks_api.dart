import 'dart:convert';
import 'package:flutter_application/models/tasks_model.dart';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TasksByProjectApi {
  static Future<List<Task>> getTasksByProject(int projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/projects/${projectId}/tasks";
    final uri = Uri.parse(url);
    // var data = {
    //   "project_id": projectId,
    // };
    var response = await http.get(
      uri,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      // body: json.encode(data),
    );
    if (response.statusCode == 200) {
      final List tasks = json.decode(response.body);

      return tasks.map((json) => Task.fromJson(json)).toList();
    } if (response.statusCode == 400) {
      return List.empty();
    } else {
      throw Exception();
    }
  }
}
