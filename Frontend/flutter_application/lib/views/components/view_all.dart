import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAll extends StatelessWidget {
  final Function()? onTap;

  const ViewAll({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            'View all',
            style: GoogleFonts.comfortaa(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 12,
          ),
        ],
      ),
    );
  }
}
