import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../components/custom_appbar.dart';
import '../../components/custom_text.dart';
import '../../theme/colors.dart';
import '../../theme/styles.dart';

class DataUserByRole extends StatefulWidget {
  const DataUserByRole({super.key, this.onTapItem, required this.role});
  final String role;

  final Function()? onTapItem;

  @override
  State<DataUserByRole> createState() => _DataUsersState();
}

class _DataUsersState extends State<DataUserByRole> {
  List<dynamic>? _listData;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void _getData() async {
    final snpUsers = await _ref.child('user/').get();
    setState(() {
      _listData = snapshotToList(snpUsers)
          .where((e) => e['role'] == widget.role)
          .toList();
    });
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
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("listData update ${jsonEncode(_listData)}");
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
          const SizedBox(
            height: 12,
          ),
          (_listData != null && _listData!.isNotEmpty)
              ? Column(
                  children: _listData!
                      .map((e) => UserItem(
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

class UserItem extends StatelessWidget {
  const UserItem({super.key, this.user});

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: AppColors.greyBgColor),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: "${user['name']}",
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
              text: user['phoneNumber'].toString().replaceAll('"', ""),
              color: AppColors.primaryColor,
              style: AppStyles.regular14),
        ],
      ),
    );
  }
}
