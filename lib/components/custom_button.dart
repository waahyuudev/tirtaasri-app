import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomButtonElevation extends StatelessWidget {
  const CustomButtonElevation(
      {super.key,
        required this.textColor,
        required this.backgroundColor,
        required this.text,
        this.onPressed,
        this.width,
        this.isProgress = false});

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function()? onPressed;
  final double? width;
  final bool isProgress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
            backgroundColor: MaterialStatePropertyAll<Color>(
                (isProgress) ? AppColors.silverCard : backgroundColor),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            ),
            elevation: const MaterialStatePropertyAll<double>(10),
            shadowColor:
            const MaterialStatePropertyAll<Color>(AppColors.whiteColor),
          ),
          onPressed: (isProgress) ? null : onPressed,
          child: (isProgress)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/json/load_merchant.json',
                  width: 20, height: 20),
              const SizedBox(
                width: 10,
              ),
              CustomText(
                  text: "Loading",
                  color: AppColors.black47,
                  style: AppStyles.bold16)
            ],
          )
              : CustomText(
              text: text, color: textColor, style: AppStyles.bold16)),
    );
  }
}