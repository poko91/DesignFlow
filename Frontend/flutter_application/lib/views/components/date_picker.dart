import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime dateTime;
  final Function(DateTime) onDateChange;
  final DateTime initialSelectedDate;

  const DatePickerWidget({
    super.key,
    required this.dateTime,
    required this.onDateChange,
    required this.initialSelectedDate
  });

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      dateTime,
      height: 100,
      width: 80,
      initialSelectedDate: initialSelectedDate,
      selectionColor: Colors.teal.shade100,
      selectedTextColor: Colors.indigo.shade400,
      dateTextStyle: GoogleFonts.comfortaa(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade400,
      ),
      dayTextStyle: GoogleFonts.comfortaa(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade400,
      ),
      monthTextStyle: GoogleFonts.comfortaa(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade400,
      ),
      onDateChange: onDateChange,
    );
  }
}
