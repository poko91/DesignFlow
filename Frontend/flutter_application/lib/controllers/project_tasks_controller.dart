import 'package:flutter_application/api/tasks/project_tasks_api.dart';
import 'package:flutter_application/models/tasks_model.dart';
import 'package:get/get.dart';

class ProjectTaskController extends GetxController {
  var isLoading = true.obs;
  var taskList = <Task>[].obs;
  RxInt numberOfTasks = 0.obs;
  int projectId = 0;

  @override
  void onInit() {
    getTasksByProject(projectId);
    super.onInit();
  }

  void getTasksByProject(projectId) async {
    try {
      isLoading(true);
      var tasks = await TasksByProjectApi.getTasksByProject(projectId);
      taskList.assignAll(tasks);
      numberOfTasks.value = taskList.length;
    } finally {
      isLoading(false);
    }
  }
}
