import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.textDecoration = TextDecoration.none,
    required this.letterSpacing,
    required this.height,
  }) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  final double letterSpacing;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: fontSize,
          color: color,
          decoration: textDecoration,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          height: height,
        ));
  }
}
