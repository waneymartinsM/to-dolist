import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist/app/utils/colors.dart';

alertDialog(context, AlertType type, String title, String text) {
  Alert(
    context: context,
    type: AlertType.none,
    title: title,
    desc: text,
    style: AlertStyle(
      backgroundColor: lightPurple,
      titleStyle: GoogleFonts.montserrat(
          color: darkPurple, fontWeight: FontWeight.bold),
      descStyle: GoogleFonts.montserrat(color: darkPurple),
    ),
    buttons: [
      DialogButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        width: 120,
        color: darkPurple,
        child: Text("Ok",
            style:  GoogleFonts.montserrat(color: Colors.white, fontSize: 20)),
        onPressed: () => Navigator.pop(context),
      )
    ],
  ).show();
}
