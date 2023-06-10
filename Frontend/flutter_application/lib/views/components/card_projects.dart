import 'package:flutter/material.dart';

class ProjectsCard extends StatelessWidget {
  final String projectName;
  final String projectStatus;
  final String dueDate;
  final Function()? onPressed;

  const ProjectsCard({
    super.key,
    required this.projectName,
    required this.projectStatus,
    required this.dueDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.indigo[400],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: onPressed,
                      icon: Icon(Icons.arrow_circle_right_outlined,
                          color: Colors.teal[200], size: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                  child: Text(
                    projectName,
                    textAlign: TextAlign.center,
                    style: TextStyle(                     
                      color: Colors.grey[100],
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  projectStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month_outlined, size: 18, color: Colors.grey[100],),
                    const SizedBox(width: 10),
                    Text(
                      dueDate,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
