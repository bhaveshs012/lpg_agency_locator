import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

TextStyle get title1Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 22.sp,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get title2Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

TextStyle get title3Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black),
  );
}

TextStyle get subtitle1Style {
  return GoogleFonts.raleway(
    textStyle: TextStyle(fontSize: 20.sp, color: Colors.black),
  );
}

TextStyle get subtitle2Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 16.sp, color: Colors.black),
  );
}

TextStyle get subtitle3Style {
  return GoogleFonts.lato(
    textStyle: TextStyle(fontSize: 14.sp, color: Colors.black),
  );
}
