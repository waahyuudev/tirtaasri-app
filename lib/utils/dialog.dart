import 'package:flutter/material.dart';

class CustomDialog {
  static void show(BuildContext context, Widget content, {Color? bgColor}) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: bgColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      content: content,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}