import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomCountTotal extends StatefulWidget {
  const CustomCountTotal({super.key, required this.total});

  final Function(int total) total;

  @override
  State<CustomCountTotal> createState() => _CustomCountTotalState();
}

class _CustomCountTotalState extends State<CustomCountTotal> {
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (total != 0) {
              setState(() {
                total--;
                widget.total(total);
              });
            }
          },
          icon: const Icon(Icons.minimize, color: AppColors.primaryColor),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.aquaLessColor),
          child: CustomText(
              align: TextAlign.center,
              text: "$total",
              color: AppColors.primaryColor,
              style: AppStyles.bold16),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              total++;
              widget.total(total);
            });
          },
          icon: const Icon(Icons.add, color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
