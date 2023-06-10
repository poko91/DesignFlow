import 'dart:convert';
import 'package:flutter_application/constant/utils.dart';
import 'package:flutter_application/models/tasks_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TasksApi {
  static Future<List<Task>> getTasks(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/tasks";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final List tasks = json.decode(response.body);

      return tasks.map((json) => Task.fromJson(json)).where((task) {
        final titleLower = task.taskTitle.toLowerCase();
        final projectLower = task.projectName.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower)
        || projectLower.contains(searchLower); 
      }).toList();
    } else {
      throw Exception();
    }
  }
}
