import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
        this.textTitle = "",
        this.withLeading = false,
        this.onBack,
        this.actions,
        this.color,
        this.titleWidget, this.elevation, this.centerTitle});

  final String textTitle;
  final bool withLeading;
  final bool? centerTitle;
  final Function()? onBack;
  final List<Widget>? actions;
  final Color? color;
  final Widget? titleWidget;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: AppColors.whiteColor,
      backgroundColor: color ?? AppColors.whiteColor,
      title: titleWidget ?? Text(textTitle),
      titleTextStyle: AppStyles.bold16.copyWith(color: AppColors.black87),
      centerTitle: centerTitle??false,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      leading: (withLeading)
          ? IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBack,
      )
          : null,
      automaticallyImplyLeading: withLeading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
