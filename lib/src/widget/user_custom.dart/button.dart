import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.containerColor,
      required this.textColor});
  VoidCallback onTap;
  String title;
  Color containerColor;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 60,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
            child: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontSize: 20,
            color: textColor,
          )),
        )),
      ),
    );
  }
}
