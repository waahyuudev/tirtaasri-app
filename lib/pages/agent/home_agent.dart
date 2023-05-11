import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_avatar.dart';
import 'package:tirtaasri_app/components/custom_button.dart';
import 'package:tirtaasri_app/components/custom_count_total.dart';
import 'package:tirtaasri_app/components/custom_menu.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/components/custom_title_menu.dart';
import 'package:tirtaasri_app/pages/agent/history_transaction.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';
import 'package:tirtaasri_app/utils/dialog.dart';
import 'package:tirtaasri_app/utils/navigation.dart';
import 'package:tirtaasri_app/utils/strings.dart';
import 'package:tirtaasri_app/utils/toast.dart';

import '../../components/custom_menu_logout.dart';
import '../../utils/preferences_util.dart';

class HomeAgent extends StatelessWidget {
  const HomeAgent({super.key, this.user});

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
          child: ListView(
        children: [
          CustomAvatar(
            name: user?["agentName"] ?? "",
          ),
          CustomText(
            text: "Agen",
            color: AppColors.primaryColor,
            style: AppStyles.regular12,
            align: TextAlign.center,
          ),
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
          CustomMenu(
            leading: SvgPicture.asset('assets/svg/mdi_box-variant.svg'),
            text: "4 Galon",
          ),
          const Divider(color: AppColors.black87),
          const SizedBox(
            height: 12,
          ),
          const CustomTitleMenu(
            title: "Fitur",
          ),
          CustomMenu(
            onTap: () {
              CustomDialog.show(
                  context,
                  UpdateStokGalon(
                    user: user,
                  ));
            },
            leading: SvgPicture.asset('assets/svg/mdi_box-variant-add.svg'),
            text: "Update Stok Galon",
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
            leading:
                SvgPicture.asset('assets/svg/pixelarticons_notes-multiple.svg'),
            text: "Riwayat Transaksi",
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomMenuLogout()
        ],
      )),
    );
  }
}

class UpdateStokGalon extends StatefulWidget {
  const UpdateStokGalon({super.key, this.user});

  final dynamic user;

  @override
  State<UpdateStokGalon> createState() => _UpdateStokGalonState();
}

class _UpdateStokGalonState extends State<UpdateStokGalon> {
  int total = 0;

  void updateStokGalon() async {
    dynamic requestData;
    String? reqKey;
    final ref = FirebaseDatabase.instance.ref();
    DataSnapshot dataSnapshot = await ref.child("request").get();

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic>? values = dataSnapshot.value as Map?;
      values?.forEach((key, item) {
        debugPrint("item ${item.runtimeType}");
        if (item['agent_name'] == widget.user['username']) {
          requestData = item;
          reqKey = key;
        }
      });
    }

    var userId = PreferencesUtil.getInt(Strings.kUserId);

    if (requestData != null) {
      await ref.update({
        "request/$reqKey/stock": total,
        "request/$reqKey/is_updated": true,
      });
    } else {
      requestData = {
        "user_id": userId,
        "agent_name": widget.user['username'],
        "stock": total,
        "is_updated": true
      };
      final newPostKey = ref.child('/request/').push().key;
      final Map<String, Map> updates = {};
      updates['/request/$newPostKey'] = requestData;
      ref.update(updates);
    }

    Navigator.pop(context);

    CustomToast.show(context, "Request terkirim", type: ToastType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: SvgPicture.asset("assets/svg/mdi_box-variant-add.svg"),
          title: CustomText(
              text: "REQUEST GALON",
              color: AppColors.primaryColor,
              style: AppStyles.bold16),
        ),
        const SizedBox(
          height: 50,
        ),
        CustomCountTotal(
          total: (value) {
            setState(() {
              total = value;
            });
          },
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButtonElevation(
              onPressed: () async {
                updateStokGalon();
              },
              textColor: AppColors.primaryColor,
              backgroundColor: AppColors.aquaMiddleColor,
              text: "Simpan"),
        )
      ],
    );
  }
}
