import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_text.dart';

class CustomAvatar extends StatelessWidget{
  const CustomAvatar({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child:
          SvgPicture.asset("assets/svg/healthicons_ui-user-profile.svg"),
        ),
        CustomText(
            text: name,
            color: AppColors.primaryColor,
            style: AppStyles.bold14),
      ],
    );
  }

}