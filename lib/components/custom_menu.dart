import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu(
      {super.key, required this.leading, required this.text, this.trailing, this.onTap});

  final Widget leading;
  final Widget? trailing;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const Divider(
            color: AppColors.black87,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                leading,
                const SizedBox(
                  width: 14,
                ),
                CustomText(
                    text: text,
                    color: AppColors.primaryColor,
                    style: AppStyles.regular12),
                const Spacer(),
                trailing ?? Container()
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}