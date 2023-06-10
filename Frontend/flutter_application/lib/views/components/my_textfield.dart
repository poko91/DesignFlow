import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  void clearText() {
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.comfortaa(fontSize: 15, color: Colors.indigo),
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
            Icons.clear,
            size: 15,
            color: Colors.indigo[400],
          ),
          onPressed: clearText,
        ),
      ),
    );
  }
}
