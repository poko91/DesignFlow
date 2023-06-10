import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/tasks_controller.dart';
import 'package:flutter_application/models/projects_model.dart';
import 'package:flutter_application/models/user_model.dart';
import 'package:flutter_application/api/users/users_api.dart';
import 'package:flutter_application/views/components/card_projects.dart';
import 'package:flutter_application/views/components/card_tasks.dart';
import 'package:flutter_application/views/components/card_tasks_noTask.dart';
import 'package:flutter_application/views/components/date_picker.dart';
import 'package:flutter_application/views/components/text_tagline.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/components/text_title_sec.dart';
import 'package:flutter_application/views/components/view_all.dart';
import 'package:flutter_application/views/pages/profile/profile_page.dart';
import 'package:flutter_application/views/pages/projects/project_details.dart';
import 'package:flutter_application/views/pages/projects/projects_page.dart';
import 'package:flutter_application/views/pages/tasks/tasks_page.dart';
import 'package:flutter_application/controllers/projects_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ProjectController projectController = Get.put(ProjectController());
  final TaskController taskController = Get.put(TaskController());
  String query = '';
  User user = const User(email: '', studioName: 'Studio Name');
  DateTime _selectedDate = DateTime.now();
  String dueDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int projectId = 0;
  late Project projData;

  @override
  void initState() {
    super.initState();
    initUser();
    projectController.getProjects();
    taskController.getTasksByDate(dueDate);
  }

  Future initUser() async {
    final user = await UserApi.getUser();
    setState(() => this.user = user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),

        // Hello
        child: Column(
          children: [
            Row(children: [
              const TitleText(title: 'Hello,'),
              const Spacer(),
              IconButton(
                onPressed: () => Get.to(() => const ProfilePage()),
                icon: const Icon(Icons.person),
                color: Colors.indigo[600],
              )
            ]),

            const SizedBox(height: 15),

            // What are we getting done today?
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TaglineText(tagline: 'What are we getting done today?'),
              ],
            ),

            const SizedBox(height: 30),

            // My projects
            Row(children: [
              const TitleText2(title: 'My Projects'),
              const Spacer(),
              ViewAll(onTap: () => Get.to(() => const ProjectsPage())),
            ]),

            const SizedBox(height: 20),

            SizedBox(
              height: 170,
              child: Obx(
                () {
                  if (projectController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: projectController.projectList.length,
                        itemBuilder: (context, index) {
                          final project = projectController.projectList[index];
                          var date =
                              projectController.projectList[index].dueDate;
                          DateTime parseDate =
                              DateFormat("yyyy-MM-dd").parse(date);
                          var inputDate = DateTime.parse(parseDate.toString());
                          String formattedDate =
                              DateFormat.MMMEd().format(inputDate);
                          return ProjectsCard(
                            onPressed: () => {             
                              Get.to(() => const ProjectDetailsPage(), arguments: project.projectId)
                            },
                            projectName: project.projectName,
                            projectStatus: project.projectStatus,
                            dueDate: formattedDate,
                          );
                        });
                  }
                },
              ),
            ),

            const SizedBox(height: 30),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TitleText2(title: "Tasks"),
                      ],
                    ),
                    ViewAll(onTap: () => Get.to(() => const TasksPage())),
                  ],
                ),
                const SizedBox(height: 15),
                DatePickerWidget(
                  dateTime: DateTime.now(),
                  initialSelectedDate: _selectedDate,
                  onDateChange: (date) {
                    _selectedDate = date;
                    dueDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
                    setState(() {
                      taskController.getTasksByDate(dueDate);
                    });
                  },
                ),
                // tasks by date
                SizedBox(
                  height: 200,
                  child: Obx(
                    () {
                      if (taskController.taskList.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: NoTasksCard(),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 20),
                            itemCount: taskController.taskList.length,
                            itemBuilder: (context, index) {
                              return TasksCard(
                                taskTitle:
                                    taskController.taskList[index].taskTitle,
                                taskDescription: taskController
                                    .taskList[index].taskDescription,
                                projectName:
                                    taskController.taskList[index].projectName,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
