import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/custom_text.dart';
import '../theme/colors.dart';
import '../theme/styles.dart';

enum ToastType { success, error, info }

enum ToastPosition { top, bottom }

class CustomToast {
  static void show(BuildContext context, String message,
      {required ToastType type,
      ToastPosition position = ToastPosition.top,
      TextAlign? textAlign}) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: (type == ToastType.success)
            ? AppColors.successColor
            : (type == ToastType.error)
                ? AppColors.redColor
                : AppColors.blackToastColor,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (textAlign != null)
                ? CustomText(
                    text: message,
                    color: AppColors.whiteColor,
                    style: AppStyles.regular14,
                    align: TextAlign.start,
                  )
                : Expanded(
                    child: CustomText(
                    text: message,
                    color: AppColors.whiteColor,
                    style: AppStyles.regular14,
                    align: TextAlign.start,
                  )),
          ],
        ),
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 3),
        positionedToastBuilder: (context, child) {
          return (position == ToastPosition.top)
              ? Positioned(
                  top: 35.0,
                  width: MediaQuery.of(context).size.width,
                  child: child,
                )
              : Positioned(
                  bottom: 35.0,
                  width: MediaQuery.of(context).size.width,
                  child: child,
                );
        });
  }
}
