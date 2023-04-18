import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';

class HistoryTransaction extends StatelessWidget {
  const HistoryTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        withLeading: true,
        centerTitle: true,
        titleWidget: Image.asset(
          "assets/png/app_bar_logo.png",
        ),
        onBack: () => Navigator.pop(context),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svg/uiw_date.svg"))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.greyBgColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomText(
                      text: "07 Feb 2023",
                      color: AppColors.greyText,
                      style: AppStyles.bold14,
                      align: TextAlign.left,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        color: AppColors.aquaColor,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "2 Galon",
                                    color: AppColors.primaryColor,
                                    style: AppStyles.bold16),
                                CustomText(
                                    text: "Rp 14.000",
                                    color: AppColors.primaryColor,
                                    style: AppStyles.bold12),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                    text: "Berhasil",
                                    color: Colors.green,
                                    style: AppStyles.bold14),
                                CustomText(
                                    text: "17.24",
                                    color: AppColors.primaryColor,
                                    style: AppStyles.bold12),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        color: AppColors.aquaColor,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "2 Galon",
                                    color: AppColors.primaryColor,
                                    style: AppStyles.bold16),
                                CustomText(
                                    text: "Rp 14.000",
                                    color: AppColors.primaryColor,
                                    style: AppStyles.bold12),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                    text: "Berhasil",
                                    color: Colors.green,
                                    style: AppStyles.bold14),
                                CustomText(
                                    text: "17.24",
                                    color: AppColors.primaryColor,
                                    style: AppStyles.bold12),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: AppColors.greyBgColor,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomText(
                      text: "07 Feb 2023",
                      color: AppColors.greyText,
                      style: AppStyles.bold14,
                      align: TextAlign.left,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    color: AppColors.aquaColor,
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: "2 Galon",
                                color: AppColors.primaryColor,
                                style: AppStyles.bold16),
                            CustomText(
                                text: "Rp 14.000",
                                color: AppColors.primaryColor,
                                style: AppStyles.bold12),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                                text: "Berhasil",
                                color: Colors.green,
                                style: AppStyles.bold14),
                            CustomText(
                                text: "17.24",
                                color: AppColors.primaryColor,
                                style: AppStyles.bold12),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
