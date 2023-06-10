import 'dart:convert';
import 'package:flutter_application/models/projects_model.dart';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProjectsApi {
  static Future<List<Project>> getProjects(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/projects";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final List projects = json.decode(response.body);

      return projects.map((json) => Project.fromJson(json)).where((project) {
        final titleLower = project.projectName.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
