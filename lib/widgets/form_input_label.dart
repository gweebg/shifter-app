import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormLabelElement extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const FormLabelElement({Key? key, required this.text, required this.fontSize, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 15),
        child: Text(text,
            style: GoogleFonts.poppins(
                fontSize: fontSize,
                color: color,
                fontWeight: FontWeight.w400)));
  }
}
