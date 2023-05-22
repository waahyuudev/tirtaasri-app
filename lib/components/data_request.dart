import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/employee/detail_request.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';
import 'package:tirtaasri_app/utils/navigation.dart';

class DataRequests extends StatefulWidget {
  const DataRequests({super.key, this.onTapItem, required this.user});

  final Function()? onTapItem;
  final dynamic user;

  @override
  State<DataRequests> createState() => _DataRequestsState();
}

class _DataRequestsState extends State<DataRequests> {
  List<dynamic>? _listData;
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void getUser(int indexUser, int index) async {
    final snpUsers = await _ref.child('users/$indexUser').get();
    setState(() {
      if (snpUsers.exists) {
        // _listData = jsonDecode(jsonEncode(snpUsers.value));
        // _listData =
        //     _listData?.where((e) => e['role'] == widget.user['role']).toList();
        // _listData?.forEach((e) {
        //   getRequest(_listData?.indexOf(e) ?? 0, e['username']);
        // });
        // debugPrint("list data ${jsonEncode(_listData)}");
        // debugPrint("list data ${_listData?.length}");
        Map<dynamic, dynamic>? values = snpUsers.value as Map?;
        values?.forEach((key, item) {
          setState(() {
            if (key == "agentName") {
              _listData?[index]['agent_name'] = item;
            }
            if (key == "address") {
              _listData?[index]['address'] = item;
            }
            if (key == "phoneNumber") {
              _listData?[index]['phone_number'] = item;
            }
          });
        });
      } else {
        debugPrint("transactions not found");
      }
    });
  }

  @override
  void initState() {
    getRequest();
    super.initState();
  }

  void getRequest() async {
    final ref = FirebaseDatabase.instance.ref();
    DataSnapshot dataSnapshot = await ref.child("request").get();

    if (dataSnapshot.value != null) {
      // Map<dynamic, dynamic>? values = dataSnapshot.value as Map?;
      _listData = snapshotToList(dataSnapshot);
      if (_listData!.isNotEmpty) {
        int index = 0;
        for (var e in _listData!) {
          getUser(e["user_id"], index);
          index++;

        }
      }
      // values?.forEach((key, item) {
      //   debugPrint("item ${item.runtimeType}");
      //   result = item['stock'];
      //   setState(() {
      //     _listData?[index]['stock'] = result.toString();
      //     _listData?[index]['is_updated'] = item['is_updated'];
      //     _listData?[index]['key_request'] = key;
      //   });
      // });
    }
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
                            text: "${user['agent_name']}",
                            color: AppColors.primaryColor,
                            style: AppStyles.regular14),
                      )
                    : CustomText(
                        text: "${user['agent_name']}",
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
                text: user['phoneNumber']??"",
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
