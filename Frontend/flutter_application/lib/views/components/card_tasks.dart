import 'package:flutter/material.dart';

class TasksCard extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String projectName;

  const TasksCard({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
    required this.projectName,
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
        height: 125,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
          border: Border.all(color: Colors.indigo.shade200)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    taskTitle,
                    style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    height: 30,
                    child: Text(
                      taskDescription,
                      style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.folder, size: 15,),
                  const SizedBox(width: 10),
                  Text(
                    projectName,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 11,
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
