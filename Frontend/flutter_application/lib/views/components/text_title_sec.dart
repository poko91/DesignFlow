import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText2 extends StatelessWidget {
  final String title;

  const TitleText2({
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
            fontSize: 20,
            color: Colors.indigo[800],
          ),
        ),
      ],
    );
  }
}
