import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GestureDetectorText extends StatelessWidget {
  final Function()? onTap;
  final String title;

  const GestureDetectorText({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.bold,
          color: Colors.indigo[800],
          fontSize: 15,
        ),
      ),
    );
  }
}


// GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => RegisterPage()));
//                     },
//                     child: Text(
//                       'Register Now',
//                       style: GoogleFonts.comfortaa(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.indigo[700],
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),