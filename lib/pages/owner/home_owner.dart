import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_menu_logout.dart';

import '../../components/custom_menu.dart';
import '../../theme/colors.dart';
import '../../utils/navigation.dart';
import '../agent/history_transaction.dart';

class HomeOwner extends StatelessWidget {
  const HomeOwner({super.key, this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Image.asset(
          "assets/png/app_bar_logo.png",
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomMenu(
              onTap: () {},
              leading: SvgPicture.asset('assets/svg/mdi_user-add-outline.svg'),
              text: "Tambah User",
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
            CustomMenu(
              onTap: () {},
              leading: SvgPicture.asset('assets/svg/mdi_people-group.svg'),
              text: "Data Agen",
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
            CustomMenu(
              onTap: () {
                // CustomDialog.show(context, const UpdateStokGalon());
              },
              leading: SvgPicture.asset('assets/svg/mdi_people-group.svg'),
              text: "Data Karyawan",
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
            CustomMenu(
              onTap: () {

              },
              leading: SvgPicture.asset(
                  'assets/svg/pixelarticons_notes-multiple.svg'),
              text: "Laporan Penjualan",
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomMenuLogout()
          ],
        ),
      ),
    );
  }
}
