import 'package:flutter_application/api/tasks/tasks_byDate_api.dart';
import 'package:flutter_application/models/tasks_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  var isLoading = true.obs;
  var taskList = <Task>[].obs;
  RxInt numberOfTasks = 0.obs;
  String dueDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  
  @override
  void onInit() {
    getTasksByDate(dueDate);
    super.onInit();
  }

  void getTasksByDate(dueDate) async {
    try {
      isLoading(true);
      var tasks = await TasksByDateApi.getTasks(dueDate);
      taskList.assignAll(tasks);
      numberOfTasks.value = taskList.length;
    } finally {
      isLoading(false);
    }
  }
}