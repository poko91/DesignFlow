import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/projects/projects_api.dart';
import 'package:flutter_application/api/tasks/create_task_api.dart';
import 'package:flutter_application/models/projects_model.dart';
import 'package:flutter_application/views/components/date_textfield.dart';
import 'package:flutter_application/views/components/my_textfield.dart';
import 'package:flutter_application/views/components/snackbar_helper.dart';
import 'package:flutter_application/views/components/text_gestureDectector.dart';
import 'package:flutter_application/views/components/text_tagline2.dart';
import 'package:flutter_application/views/pages/tasks/tasks_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/text_title.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String dueDate = '';
  String _selectPriority = "High";
  final List<String> _priorityList = ["High", "Medium", "Low"];

  String query = '';
  late Future<List<Project>> _future;
  Project? _selectedProject;

  // controllers
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = ProjectsApi.getProjects(query);
  }

  Future createTask() async {
    // Showing CircularProgressIndicator.
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade700),
          ),
        );
      },
    );

    // Getting value from Controller
    String taskTitle = titleController.text;
    String taskDescription = descController.text;
    String dueDateText = dueDate;
    String priority = _selectPriority;
    String? projectName = _selectedProject?.projectName;

    final response = await CreateTaskApi.createTask(
        taskTitle, taskDescription, dueDateText, priority, projectName!);
    var resBody = json.decode(response.body);

    if (response.statusCode == 200) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      () => Get.to(() => const TasksPage());
      if (context.mounted)
        showSnackBar(context, message: 'Task created succeffully!');
    } else if (response.statusCode == 400) {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted) showSnackBar(context, message: resBody["message"]);
      () => Get.back();
    } else {
      // Hiding the CircularProgressIndicator.
      if (context.mounted) Navigator.of(context).pop();
      if (context.mounted)
        showSnackBar(context,
            message: 'An error occurred. Please try again later.');
      () => Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          // Add Task
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              const TitleText(title: "Add Task"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetectorText(
                    title: 'Done',
                    onTap: () {
                      if (titleController.text.isNotEmpty || descController.text.isNotEmpty) {
                        createTask();
                      } else {
                        showSnackBar(context, message: "All fields must be filled");
                      }
                    }),
              )
            ],
          ),
          const SizedBox(height: 30),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                TaglineText2(tagline: 'Title'),
                const SizedBox(height: 5),
                MyTextField(
                  controller: titleController,
                  hintText: 'Enter Task Title',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                // task description
                TaglineText2(tagline: 'Description'),
                const SizedBox(height: 5),
                MyTextField(
                  controller: descController,
                  hintText: 'Enter Task Description',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                // Due date
                TaglineText2(tagline: 'Due Date'),
                const SizedBox(height: 5),
                DateTextField(
                  controller: dateController,
                  hintText: DateFormat.yMMMMd().format(_selectedDate),
                  onPressed: () {
                    getDateFromUser();
                  },
                ),
                const SizedBox(height: 25),
                // priority
                TaglineText2(tagline: 'Priority'),
                const SizedBox(height: 5),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.indigo.shade200,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton(
                      value: _selectPriority,
                      isExpanded: true,
                      items: _priorityList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectPriority = newValue!;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.indigo.shade400,
                      ),
                      iconSize: 25,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.indigo),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Project name
                TaglineText2(tagline: 'Project name'),
                const SizedBox(height: 5),
                FutureBuilder<List<Project>>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }

                      return Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.indigo.shade200,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButton<Project>(
                            isExpanded: true,
                            onChanged: (project) =>
                                setState(() => _selectedProject = project),
                            value: _selectedProject,
                            items: [
                              ...snapshot.data!.map(
                                (project) => DropdownMenuItem(
                                  value: project,
                                  child: Text(project.projectName),
                                ),
                              ),
                            ],
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.indigo.shade400,
                            ),
                            iconSize: 25,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.indigo),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2035),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        dueDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    } else {
      print('Error occurred while picking date');
    }
  }
}
