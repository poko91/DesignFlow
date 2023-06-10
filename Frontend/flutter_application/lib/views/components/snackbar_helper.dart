import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: GoogleFonts.comfortaa(
        color: Colors.white,
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 90, 105, 190),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
