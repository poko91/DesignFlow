import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function()? onPressed;

  const AddButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        Icons.add,
        color: Colors.indigo[800],
        size: 18,
      ),
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.grey[100],
        side: BorderSide(color: Colors.indigo.shade200)
      ),
      label: Text(
        'Add',
        style: TextStyle(
          color: Colors.indigo[800],
          fontSize: 13,
        ),
      ),
    );
  }
}
