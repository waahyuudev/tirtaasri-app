import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_menu_logout.dart';
import 'package:tirtaasri_app/pages/owner/add_user_page.dart';
import 'package:tirtaasri_app/pages/owner/data_employee.dart';
import 'package:tirtaasri_app/components/data_laporan.dart';

import '../../components/custom_menu.dart';
import '../../components/data_user.dart';
import '../../theme/colors.dart';
import '../../utils/navigation.dart';

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
              onTap: () {
                CustomNavigation.pushNavigate(
                    context: context, screen: AddUserPage());
              },
              leading: SvgPicture.asset('assets/svg/mdi_user-add-outline.svg'),
              text: "Tambah User",
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
            CustomMenu(
              onTap: () {
                CustomNavigation.pushNavigate(
                    context: context, screen: DataUsers(user: user));
              },
              leading: SvgPicture.asset('assets/svg/mdi_people-group.svg'),
              text: "Data Agen",
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              ),
            ),
            CustomMenu(
              onTap: () {
                CustomNavigation.pushNavigate(
                    context: context, screen: DataEmployee(user: user));
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
                CustomNavigation.pushNavigate(context: context, screen: DataLaporan(user: user, ));
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
