import 'package:flutter/material.dart';

class TasksCardLong extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String projectName;
  final String dueDate;

  const TasksCardLong({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    required this.projectName,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: 140,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: Text(
                      taskTitle,
                      style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    height: 30,
                    child: Text(
                      taskDescription,
                      style: TextStyle(
                        color: Colors.indigo[500],
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.folder, size: 15,),
                  const SizedBox(width: 10),
                  Text(
                    projectName,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  // due date
                  Text(
                    dueDate,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
