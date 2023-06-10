import 'package:flutter/material.dart';

class TasksTile extends StatelessWidget {
  final String taskName;
  final String priority;
  final String taskDescription;
  final String dueDate;
  final String projectName;

  const TasksTile({
    super.key,
    required this.taskName,
    required this.priority,
    required this.taskDescription,
    required this.dueDate,
    required this.projectName,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        height: 160,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.teal[50],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    taskName,
                    style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.calendar_month, size: 15,),
                  SizedBox(width: 10),
                  Text(
                    dueDate,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.folder, size: 15,),
                  SizedBox(width: 10,),
                  Text(
                    projectName,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Priority : " + priority,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 14,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
