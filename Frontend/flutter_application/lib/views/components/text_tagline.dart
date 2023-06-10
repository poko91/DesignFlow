import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaglineText extends StatelessWidget {
  final String tagline;

  TaglineText({
    super.key,
    required this.tagline,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      tagline,
      style: GoogleFonts.comfortaa(
        color: Colors.grey[700],
        fontSize: 15,
      ),
    );
  }
}
