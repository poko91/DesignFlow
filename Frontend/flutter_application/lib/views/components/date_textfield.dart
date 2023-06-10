import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final Function()? onPressed;

  DateTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPressed,
  });

  void clearText() {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.shade600),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.comfortaa(
          fontSize: 15,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_month_outlined,
            size: 25,
            color: Colors.indigo.shade400,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
