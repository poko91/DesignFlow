import 'dart:convert';
import 'package:flutter_application/models/tasks_model.dart';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TasksByDateApi {
  static Future<List<Task>> getTasks(String dueDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/tasksByDate";
    final uri = Uri.parse(url);
    var data = {
      "due_date": dueDate,
    };
    var response = await http.post(
      uri,
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer $accessToken"
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      final List tasks = json.decode(response.body);

      return tasks.map((json) => Task.fromJson(json)).toList();
    } if (response.statusCode == 404) {
      return List.empty();
    } else {
      throw Exception();
    }
  }
}
