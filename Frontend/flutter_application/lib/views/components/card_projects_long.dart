import 'package:flutter/material.dart';

class ProjectsCardLong extends StatelessWidget {
  final String projectName;
  final String projectStatus;
  final String dueDate;
  final String projectType;
  final String projectAdd;

  const ProjectsCardLong({
    super.key,
    required this.projectName,
    required this.projectStatus,
    required this.dueDate,
    required this.projectType,
    required this.projectAdd,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shadowColor: Colors.grey.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        // side: BorderSide(color: Color.fromARGB(255, 224, 214, 241))
      ),
      child: Container(
        height: 80,
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
                  Text(
                    projectName,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    projectStatus,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    projectType,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 18),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     const Icon(Icons.calendar_month_outlined, color: Colors.indigo, size: 20,),
              //     const SizedBox(width: 10),
              //     Text(
              //       dueDate,
              //       style: const TextStyle(
              //         color: Colors.indigo,
              //         fontSize: 12,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 5),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     const Icon(Icons.pin_drop_outlined, color: Colors.indigo, size: 20,),
              //     const SizedBox(width: 10),
              //     Text(
              //       projectAdd,
              //       style: const TextStyle(
              //         color: Colors.indigo,
              //         fontSize: 12,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
