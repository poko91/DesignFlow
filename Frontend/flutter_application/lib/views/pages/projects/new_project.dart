import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/projects/create_project_api.dart';
import 'package:flutter_application/controllers/projects_controller.dart';
import 'package:flutter_application/views/components/date_textfield.dart';
import 'package:flutter_application/views/components/my_textfield.dart';
import 'package:flutter_application/views/components/snackbar_helper.dart';
import 'package:flutter_application/views/components/text_gestureDectector.dart';
import 'package:flutter_application/views/components/text_tagline2.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../components/text_title.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  DateTime _selectedDate = DateTime.now();
  String dueDate = '';
  String _selectType = "Residential";
  final List<String> _typeList = ["Residential", "Commercial", "Other"];
  String _selectStatus = "In progress";
  final List<String> _statusList = ["In progress", "On hold", "Completed"];
  final ProjectController projectController = Get.find();

  // controllers
  final nameController = TextEditingController();
  final addController = TextEditingController();
  final dateController = TextEditingController();

  Future createProject() async {
    // Showing CircularProgressIndicator.
    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade700),
        ),
      ),
    );

    // Getting value from Controller
    String projectName = nameController.text;
    String projectType = _selectType;
    String projectStatus = _selectStatus;
    String projectAdd = addController.text;
    String dueDateText = dueDate;

    final response = await CreateProjectApi.createProject(
        projectName, projectType, projectStatus, projectAdd, dueDateText);
    var resBody = json.decode(response.body);

    if (response.statusCode == 200) {
    // Hiding the CircularProgressIndicator.
    Get.back();
    showSnackBar(context, message: 'Project created successfully!');
    // Fetch the updated list of projects
    projectController.getProjects();
    Get.back();
  } else if (response.statusCode == 400) {
    // Hiding the CircularProgressIndicator.
    Get.back();
    showSnackBar(context, message: resBody["message"]);
  } else {
    // Hiding the CircularProgressIndicator.
    Get.back();
    showSnackBar(context, message: 'An error occurred. Please try again later.');
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
              const TitleText(title: "Add Project"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetectorText(
                    title: 'Done',
                    onTap: () {
                      if (nameController.text.isNotEmpty || addController.text.isNotEmpty) {
                        createProject();
                      } else {
                        showSnackBar(context, message: "All fields must be filled");
                      }
                    }),
              )
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project name
                TaglineText2(tagline: 'Project Name'),
                const SizedBox(height: 5),
                MyTextField(
                  controller: nameController,
                  hintText: 'Enter Project Name',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                // Project Type
                TaglineText2(tagline: 'Project Type'),
                const SizedBox(height: 5),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.indigo.shade200,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton(
                        value: _selectType,
                        isExpanded: true,
                        items: _typeList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectType = newValue!;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.indigo.shade400,
                        ),
                        iconSize: 25,
                        style: GoogleFonts.comfortaa(
                            fontSize: 15, color: Colors.indigo)),
                  ),
                ),
                const SizedBox(height: 25),
                // Project status
                TaglineText2(tagline: 'Project Status'),
                const SizedBox(height: 5),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.indigo.shade200,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton(
                        value: _selectStatus,
                        isExpanded: true,
                        items: _statusList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectStatus = newValue!;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.indigo.shade400,
                        ),
                        iconSize: 25,
                        style: GoogleFonts.comfortaa(
                            fontSize: 15, color: Colors.indigo)),
                  ),
                ),
                const SizedBox(height: 25),
                // Project address
                TaglineText2(tagline: 'Address'),
                const SizedBox(height: 5),
                MyTextField(
                  controller: addController,
                  hintText: 'Enter Project Address',
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
              ],
            ),
          ),
        ],
      ),
    ));
  }

  getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2035),
    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
        dueDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    } else {
      showSnackBar(context, message: 'Error occurred while picking date');
    }
  }
}
