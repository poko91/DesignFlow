import 'dart:convert';
import 'package:flutter_application/models/projects_model.dart';
import 'package:flutter_application/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProjectByIdApi {
  static Future<Project> getProject(int projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('access_token');
    final url = "${Utils.baseUrl}/users/projects/${projectId}";
    final uri = Uri.parse(url);
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      final projectJson = json.decode(response.body);
      List<dynamic> projects = projectJson['project'];
      Map<String, dynamic> firstProject = projects[0];
      Project project = Project.fromJson(firstProject);
      return project;
    } else {
      throw Exception();
    }
  }
}
