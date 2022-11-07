import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolist/app/utils/colors.dart';

alertDialog(context, AlertType type, String title, String text) {
  Alert(
    context: context,
    type: AlertType.none,
    title: title,
    desc: text,
    style: const AlertStyle(
      backgroundColor: lightPurple,
      titleStyle: TextStyle(
        color: darkPurple,
        fontWeight: FontWeight.bold,
      ),
      descStyle: TextStyle(
        color: darkPurple,
      ),
    ),
    buttons: [
      DialogButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        width: 120,
        color: darkPurple,
        child: const Text(
          "Ok",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      )
    ],
  ).show();
}
