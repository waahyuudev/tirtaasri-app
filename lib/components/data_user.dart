import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/employee/detail_request.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';
import 'package:tirtaasri_app/utils/navigation.dart';

class DataUsers extends StatefulWidget {
  const DataUsers({super.key, this.onTapItem, required this.role});

  final Function()? onTapItem;
  final String role;

  @override
  State<DataUsers> createState() => _DataUsersState();
}

class _DataUsersState extends State<DataUsers> {
  List<dynamic>? _listData;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void _getData() async {
    final snpUsers = await _ref.child('users/').get();
    // final snTransactions = await _ref.child('transactions/').get();
    setState(() {
      if (snpUsers.exists) {
        _listData = jsonDecode(jsonEncode(snpUsers.value));
        _listData = _listData?.where((e) => e['role'] == widget.role).toList();
        debugPrint("list data ${jsonEncode(_listData)}");
        debugPrint("list data ${_listData?.length}");
      } else {
        debugPrint("transactions not found");
      }
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

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
          (_listData != null)
              ? Column(
                  children: _listData!
                      .map((e) => ItemNotification(
                            user: e,
                          ))
                      .toList(),
                )
              : Center(
                  child: CustomText(
                      text: "Data tidak ditemukan",
                      color: AppColors.primaryColor,
                      style: AppStyles.regular14),
                )
        ],
      )),
    );
  }
}

class ItemNotification extends StatelessWidget {
  const ItemNotification(
      {super.key, this.isExistNotification, this.onTap, this.user});

  final bool? isExistNotification;
  final dynamic user;
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
                (isExistNotification ?? false)
                    ? Badge(
                        child: CustomText(
                            text: "${user['name']} (ibu sutini)",
                            color: AppColors.primaryColor,
                            style: AppStyles.regular14),
                      )
                    : CustomText(
                        text: "${user['name']} (ibu sutini)",
                        color: AppColors.primaryColor,
                        style: AppStyles.regular14),
                CustomText(
                    text: user['address'],
                    color: AppColors.primaryColor,
                    style: AppStyles.regular10),
              ],
            ),
            const Spacer(),
            CustomText(
                text: user['phoneNumber'],
                color: AppColors.primaryColor,
                style: AppStyles.regular14),
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
