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
  const DataUsers({super.key, this.onTapItem, required this.user});

  final Function()? onTapItem;
  final dynamic user;

  @override
  State<DataUsers> createState() => _DataUsersState();
}

class _DataUsersState extends State<DataUsers> {
  List<dynamic>? _listData;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void _getData() async {
    final snpUsers = await _ref.child('users/').get();
    setState(() {
      if (snpUsers.exists) {
        _listData = jsonDecode(jsonEncode(snpUsers.value));
        _listData =
            _listData?.where((e) => e['role'] == widget.user['role']).toList();
        _listData?.forEach((e) {
          getStock(_listData?.indexOf(e) ?? 0, e['username']);
        });
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

  Future<int> getStock(int index, String username) async {
    int result = 0;
    final ref = FirebaseDatabase.instance.ref();
    DataSnapshot dataSnapshot = await ref.child("request").get();

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic>? values = dataSnapshot.value as Map?;
      values?.forEach((key, item) {
        debugPrint("item ${item.runtimeType}");
        if (item['agent_name'] == username) {
          result = item['stock'];
          setState(() {
            _listData?[index]['stock'] = result.toString();
            _listData?[index]['is_updated'] = item['is_updated'];
            _listData?[index]['key_request'] = key;
          });
        }
      });
    }
    return result;
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
                            isExistNotification: e['is_updated'],
                            onTap: () {
                              CustomNavigation.pushNavigate(
                                  context: context,
                                  screen: DetailRequest(
                                    user: widget.user,
                                    data: e,
                                  ));
                            },
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
                            text: "${user['name']}",
                            color: AppColors.primaryColor,
                            style: AppStyles.regular14),
                      )
                    : CustomText(
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
                text: user['phoneNumber'],
                color: AppColors.primaryColor,
                style: AppStyles.regular14),
            const Spacer(),
            CustomText(
                text: "${user['stock']} Galon",
                color: AppColors.primaryColor,
                style: AppStyles.regular14),
          ],
        ),
      ),
    );
  }
}
