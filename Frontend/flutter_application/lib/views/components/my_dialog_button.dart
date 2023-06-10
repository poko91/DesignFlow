import 'package:flutter/material.dart';

class MyDialogButton extends StatelessWidget {
  final String name;
  final Function()? onTap;

  const MyDialogButton({
    super.key, 
    required this.name, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.indigo[600],
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
