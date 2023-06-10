import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDialogTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool autofocus;

  MyDialogTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo.shade400),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.comfortaa(
          fontSize: 13,
        )
      ),
    );
  }
}
