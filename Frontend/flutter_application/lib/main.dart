import 'package:flutter/material.dart';
import 'package:flutter_application/views/pages/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'designFlow',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.comfortaaTextTheme(
          Theme.of(context).textTheme
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.indigo[400],
          cursorColor: Colors.indigo[400],
          selectionHandleColor:Colors.indigo[400],
        ),
        iconTheme: IconThemeData(color: Colors.indigo[400]),
      ),
      home: const WelcomeScreen(),
    );
  }
}