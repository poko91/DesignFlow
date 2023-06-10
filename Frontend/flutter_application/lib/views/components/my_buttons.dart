import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String name;
  final Function()? onTap;

  const MyButton({
    super.key, 
    required this.name, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.indigo[400],
          borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
