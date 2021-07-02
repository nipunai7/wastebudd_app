import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  String text;
  Color color;
  FontWeight fontWeight;
  double fontSize;

  CustomText({this.text, this.color, this.fontWeight, this.fontSize,});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.raleway(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
    ),);
  }
}
