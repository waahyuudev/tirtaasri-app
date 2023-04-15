import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomTitleMenu extends StatelessWidget{
  const CustomTitleMenu({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12, left: 16),
      child: CustomText(
          text: title,
          color: AppColors.primaryColor,
          style: AppStyles.bold16,
          align: TextAlign.start),
    );
  }

}