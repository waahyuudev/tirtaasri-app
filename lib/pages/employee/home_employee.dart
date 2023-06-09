import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_avatar.dart';
import 'package:tirtaasri_app/components/custom_menu_logout.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/employee/list_request.dart';
import 'package:tirtaasri_app/theme/styles.dart';

import '../../components/custom_menu.dart';
import '../../components/custom_title_menu.dart';
import '../../components/data_request.dart';
import '../../theme/colors.dart';
import '../../utils/navigation.dart';
import '../agent/history_transaction.dart';
import '../owner/data_employee.dart';

class HomeEmployee extends StatefulWidget {
  const HomeEmployee({super.key, this.user});

  final dynamic user;

  @override
  State<HomeEmployee> createState() => _HomeEmployeeState();
}

class _HomeEmployeeState extends State<HomeEmployee> {
  int totalRequest = 0;

  @override
  void initState() {
    DatabaseReference totalRequestRef =
        FirebaseDatabase.instance.ref('request/');
    totalRequestRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot;
      var listRequest =
          snapshotToList(data).where((e) => e['is_updated']).toList();
      setState(() {
        totalRequest = listRequest.length;
      });
    });

    super.initState();
  }

  List<dynamic> snapshotToList(DataSnapshot snapshot) {
    List<dynamic> list = [];
    Map<dynamic, dynamic> values = snapshot.value as Map;
    values.forEach((key, value) {
      list.add(value);
    });

    return list;
  }

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
                    context: context,
                    screen: ListRequestPage(user: widget.user));
              },
              icon: totalRequest == 0
                  ? SvgPicture.asset("assets/svg/ic_notification.svg")
                  : Badge(
                      label: CustomText(
                          text: "$totalRequest",
                          color: AppColors.whiteColor,
                          style: AppStyles.bold12),
                      child: SvgPicture.asset("assets/svg/ic_notification.svg"),
                    )),
          SizedBox(
            width: 22,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomAvatar(name: widget.user?["name"] ?? ""),
            const CustomTitleMenu(
              title: "Profile",
            ),
            CustomMenu(
                leading:
                    SvgPicture.asset('assets/svg/iconoir_profile-circle.svg'),
                text: widget.user?["name"] ?? "",
                trailing: SvgPicture.asset(
                    'assets/svg/material-symbols_edit-square-outline-sharp.svg')),
            CustomMenu(
                leading: SvgPicture.asset('assets/svg/ic_home_menu.svg'),
                text: widget.user?["address"] ?? "",
                trailing: SvgPicture.asset(
                    'assets/svg/material-symbols_edit-square-outline-sharp.svg')),
            CustomMenu(
                leading: SvgPicture.asset(
                    'assets/svg/material-symbols_perm-phone-msg-sharp.svg'),
                text: widget.user?["phoneNumber"] ?? "",
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
                    context: context, screen: const DataUserByRole(role: "agent",));
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
                      user: widget.user,
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
