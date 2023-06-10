import 'package:flutter/material.dart';
import 'package:flutter_application/api/projects/projectById_api.dart';
import 'package:flutter_application/controllers/project_tasks_controller.dart';
import 'package:flutter_application/models/projects_model.dart';
import 'package:flutter_application/views/components/card_tasks_long.dart';
import 'package:flutter_application/views/components/card_tasks_noTask.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/components/text_title_sec.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final ProjectTaskController taskController = Get.put(ProjectTaskController());
  Project? project;

  @override
  void initState() {
    super.initState();
    initProjDetails();
    taskController.getTasksByProject(Get.arguments);
  }

  Future<void> initProjDetails() async {
    final fetchedProject = await ProjectByIdApi.getProject(Get.arguments);
    setState(() {
      project = fetchedProject;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: [
            // Project Name
            Row(children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              TitleText(title: project?.projectName ?? ''),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                color: Colors.indigo[600],
                iconSize: 20,
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  // Project address
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Address: ${project?.projectAdd ?? ''}",
                            style: TextStyle(
                                fontSize: 17, color: Colors.indigo[900]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Project Type
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Project type :  ${project?.projectType ?? ''}",
                        style: GoogleFonts.comfortaa(
                          color: Colors.indigo[900],
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Project status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Project status :  ${project?.projectStatus ?? ''}",
                        style: GoogleFonts.comfortaa(
                          color: Colors.indigo[900],
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Project due date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Due Date :  ${project?.dueDate ?? ''}",
                        style: GoogleFonts.comfortaa(
                          color: Colors.indigo[900],
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  // Project due date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      TitleText2(title: "Project Tasks"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // tasks by date
                  SizedBox(
                    height: 360,
                    child: Obx(
                      () {
                        if (taskController.taskList.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(0),
                            child: NoTasksCard(),
                          );
                        } else {
                          return Expanded(
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 10);
                              },
                              padding: const EdgeInsets.all(0),
                              itemCount: taskController.taskList.length,
                              itemBuilder: (context, index) {
                                var date =
                                    taskController.taskList[index].dueDate;
                                DateTime parseDate =
                                    DateFormat("yyyy-MM-dd").parse(date);
                                var inputDate =
                                    DateTime.parse(parseDate.toString());
                                String formattedDate =
                                    DateFormat.MMMEd().format(inputDate);
                                return TasksCardLong(
                                    taskTitle: taskController
                                        .taskList[index].taskTitle,
                                    taskDescription: taskController
                                        .taskList[index].taskDescription,
                                    projectName: taskController
                                        .taskList[index].projectName,
                                    dueDate: formattedDate);
                              },
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
