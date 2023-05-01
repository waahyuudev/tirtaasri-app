import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_avatar.dart';
import 'package:tirtaasri_app/components/custom_menu_logout.dart';
import 'package:tirtaasri_app/components/data_user.dart';

import '../../components/custom_menu.dart';
import '../../components/custom_title_menu.dart';
import '../../theme/colors.dart';
import '../../utils/navigation.dart';
import '../agent/history_transaction.dart';

class HomeEmployee extends StatelessWidget {
  const HomeEmployee({super.key, this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Image.asset(
          "assets/png/app_bar_logo.png",
        ),
        onBack: () => Navigator.pop(context),
        actions: [
          IconButton(
              onPressed: () {
                CustomNavigation.pushNavigate(
                    context: context, screen: DataUsers(user: user));
              },
              icon: Badge(
                child: SvgPicture.asset("assets/svg/ic_notification.svg"),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAvatar(name: user?["name"] ?? ""),
            const CustomTitleMenu(
              title: "Profile",
            ),
            CustomMenu(
                leading:
                    SvgPicture.asset('assets/svg/iconoir_profile-circle.svg'),
                text: user?["name"] ?? "",
                trailing: SvgPicture.asset(
                    'assets/svg/material-symbols_edit-square-outline-sharp.svg')),
            CustomMenu(
                leading: SvgPicture.asset('assets/svg/ic_home_menu.svg'),
                text: user?["address"] ?? "",
                trailing: SvgPicture.asset(
                    'assets/svg/material-symbols_edit-square-outline-sharp.svg')),
            CustomMenu(
                leading: SvgPicture.asset(
                    'assets/svg/material-symbols_perm-phone-msg-sharp.svg'),
                text: user?["phoneNumber"] ?? "",
                trailing: SvgPicture.asset(
                    'assets/svg/material-symbols_edit-square-outline-sharp.svg')),
            const Divider(color: AppColors.black87),
            const SizedBox(
              height: 12,
            ),
            const CustomTitleMenu(
              title: "Fitur",
            ),
            CustomMenu(
              onTap: () {
                CustomNavigation.pushNavigate(
                    context: context,
                    screen: DataUsers(
                      user: user,
                    ));
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
                    context: context,
                    screen: HistoryTransaction(
                      user: user,
                    ));
              },
              leading: SvgPicture.asset(
                  'assets/svg/pixelarticons_notes-multiple.svg'),
              text: "Riwayat Transaksi",
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
