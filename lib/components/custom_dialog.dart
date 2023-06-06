import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomDialog {
  CustomDialog({
    required this.title,
    required this.description,
    required this.textButton,
    required this.onOkButtonPressed,
  });

  final String title;
  final String description;
  final String textButton;
  final Function() onOkButtonPressed;

  void show(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      onPressed: onOkButtonPressed,
      child: CustomText(
          text: textButton,
          color: AppColors.primaryColor,
          style: AppStyles.bold14),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: CustomText(
          text: title, color: AppColors.black87, style: AppStyles.bold24),
      content: StyledText(
        text: description,
        style: AppStyles.regular14.copyWith(color: AppColors.black87),
        tags: {
          'bold': StyledTextTag(
              style: AppStyles.bold14.copyWith(color: AppColors.black87)),
        },
      ),
      actions: [
        okButton,
      ],
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