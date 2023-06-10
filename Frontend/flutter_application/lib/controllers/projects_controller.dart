import 'package:flutter_application/api/projects/projects_api.dart';
import 'package:get/get.dart';

import '../models/projects_model.dart';

class ProjectController extends GetxController {
  var isLoading = true.obs;
  var projectList = <Project>[].obs;
  String query = '';

  @override
  void onInit() {
    getProjects();
    super.onInit();
  }

  void getProjects() async {
    try {
      isLoading(true);
      var projects = await ProjectsApi.getProjects(query);
      projectList.assignAll(projects);
    } finally {
      isLoading(false);
    }
  }
}
