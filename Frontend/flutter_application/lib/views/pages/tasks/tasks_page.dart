import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application/api/tasks/tasks_api.dart';
import 'package:flutter_application/models/tasks_model.dart';
import 'package:flutter_application/views/components/add_button.dart';
import 'package:flutter_application/views/components/card_tasks_long.dart';
import 'package:flutter_application/views/components/card_tasks_noTask.dart';
import 'package:flutter_application/views/components/search_bar_textfield.dart';
import 'package:flutter_application/views/components/text_title.dart';
import 'package:flutter_application/views/pages/tasks/new_task.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  List<Task> tasks = [];
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
    final tasks = await TasksApi.getTasks(query);
    setState(() => this.tasks = tasks);
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          // My Projects
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios, size: 20),
              ),
              const TitleText(title: 'Tasks'),
              const Spacer(),
              AddButton(
                onPressed: () => Get.to(() => const AddTaskPage()),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // search projects/tasks
          buildSearch(),

          const SizedBox(height: 50),

          //tabs
          DefaultTabController(
            length: 3,
            child: TabBar(
                controller: tabController,
                labelStyle:
                    GoogleFonts.comfortaa(fontSize: 15, color: Colors.indigo),
                labelColor: Colors.indigo[900],
                unselectedLabelColor: Colors.grey[400],
                indicatorColor: Colors.indigo[400],
                tabs: const [
                  Tab(text: "High"),
                  Tab(text: "Medium"),
                  Tab(text: "Low"),
                ]),
          ),

          const SizedBox(height: 10),

          // Tab bar view
          Expanded(
            child: TabBarView(controller: tabController, children: [
              // high
              ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 1);
                  },
                  padding: EdgeInsets.zero,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    var date = task.dueDate;
                    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
                    var inputDate = DateTime.parse(parseDate.toString());
                    String formattedDate = DateFormat.MMMEd().format(inputDate);
                    if (task.priority == "High") {
                      return TasksCardLong(
                        taskTitle: task.taskTitle,
                        taskDescription: task.taskDescription,
                        projectName: task.projectName,
                        dueDate: formattedDate,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              // medium
              ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 1);
                  },
                  padding: EdgeInsets.zero,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    var date = task.dueDate;
                    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
                    var inputDate = DateTime.parse(parseDate.toString());
                    String formattedDate = DateFormat.MMMEd().format(inputDate);
                    if (task.priority == "Medium") {
                      return TasksCardLong(
                        taskTitle: task.taskTitle,
                        taskDescription: task.taskDescription,
                        projectName: task.projectName,
                        dueDate: formattedDate,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
              // Low
              ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 1);
                  },
                  padding: EdgeInsets.zero,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    var date = task.dueDate;
                    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
                    var inputDate = DateTime.parse(parseDate.toString());
                    String formattedDate = DateFormat.MMMEd().format(inputDate);
                    if (task.priority == "Low") {
                      return TasksCardLong(
                        taskTitle: task.taskTitle,
                        taskDescription: task.taskDescription,
                        projectName: task.projectName,
                        dueDate: formattedDate,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
            ]),
          )
          // tasks cards horizontal
        ],
      ),
    ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search Tasks or Projects',
        onChanged: searchProject,
      );

  Future searchProject(String query) async => debounce(() async {
        final tasks = await TasksApi.getTasks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.tasks = tasks;
        });
      });
}
