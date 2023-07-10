import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/projects/projects_api.dart';
import 'package:flutter_application/controllers/projects_controller.dart';
import 'package:flutter_application/models/projects_model.dart';
import 'package:flutter_application/views/components/add_button.dart';
import 'package:flutter_application/views/components/card_projects_long.dart';
import 'package:flutter_application/views/components/search_bar_textfield.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/pages/projects/new_project.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final ProjectController projectController = Get.put(ProjectController());
  List<Project> projects = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final projects = await ProjectsApi.getProjects(query);

    setState(() => this.projects = projects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
          children: [
            // My Projects
            Row(
              children: [
                IconButton(
                  onPressed: ()=> Get.back(),
                  icon: Icon(Icons.arrow_back_ios, size: 20.w),
                ),
                const TitleText(title: 'Projects'),
                const Spacer(),
                AddButton(
                  onPressed: ()=> Get.to(() => const AddProjectPage()),
                ),
              ],
            ),
        
            SizedBox(height: 30.h),
        
            // search projects/tasks
            buildSearch(),
        
            SizedBox(height: 20.h),
        
            // Project cards horizontal
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 1.h);
                  },
                  padding: EdgeInsets.zero,
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    var date = project.dueDate;
                    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
                    var inputDate = DateTime.parse(parseDate.toString());
                    String formattedDate = DateFormat.MMMEd().format(inputDate);
                    return ProjectsCardLong(
                        projectName: project.projectName,
                        projectStatus: project.projectStatus,
                        projectType: project.projectType,
                        dueDate: 'Due Date: $formattedDate',
                        projectAdd: project.projectAdd);
                  }),
            ),
          ],
              ),
            ),
        ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search Projects',
        onChanged: searchProject,
      );

  Future searchProject(String query) async => debounce(() async {
        final projects = await ProjectsApi.getProjects(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.projects = projects;
        });
      });
}
