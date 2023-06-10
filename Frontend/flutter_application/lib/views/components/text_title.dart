import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.comfortaa(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.indigo[800],
          ),
        ),
      ],
    );
  }
}
