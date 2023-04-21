import 'package:flutter/material.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/employee/detail_request.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';
import 'package:tirtaasri_app/utils/navigation.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          onBack: () => Navigator.pop(context),
          withLeading: true,
          titleWidget: Image.asset(
            "assets/png/app_bar_logo.png",
          )),
      body: SafeArea(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: AppColors.greyBgColor),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomText(
                  text: "Total Request : 10 Galon",
                  color: AppColors.primaryColor,
                  style: AppStyles.regular10),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ItemNotification(
            onTap: () {
              CustomNavigation.pushNavigate(
                  context: context, screen: const DetailRequest());
            },
            isExistNotification: true,
          ),
          const ItemNotification(
            isExistNotification: false,
          ),
          const ItemNotification(
            isExistNotification: true,
          ),
          const ItemNotification(
            isExistNotification: false,
          ),
        ],
      )),
    );
  }
}

class ItemNotification extends StatelessWidget {
  const ItemNotification(
      {super.key, required this.isExistNotification, this.onTap});

  final bool isExistNotification;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: AppColors.greyBgColor),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (isExistNotification)
                    ? Badge(
                        child: CustomText(
                            text: "Tia Siomat (ibu sutini)",
                            color: AppColors.primaryColor,
                            style: AppStyles.regular14),
                      )
                    : CustomText(
                        text: "Tia Siomat (ibu sutini)",
                        color: AppColors.primaryColor,
                        style: AppStyles.regular14),
                CustomText(
                    text: "Jalan raya mandala bampel",
                    color: AppColors.primaryColor,
                    style: AppStyles.regular10),
              ],
            ),
            const Spacer(),
            CustomText(
                text: "3 Galon",
                color: AppColors.primaryColor,
                style: AppStyles.regular14),
          ],
        ),
      ),
    );
  }
}
