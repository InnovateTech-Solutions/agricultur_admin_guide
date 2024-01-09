import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

headerTitle(String title, VoidCallback onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(
            textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
      ),
      TextButton(
          onPressed: onTap,
          child: Text(
            "See more",
            style: GoogleFonts.poppins(
                textStyle:
                    TextStyle(fontSize: 18, color: ColorConst.mainTextColor)),
          ))
    ],
  );
}
