import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/employee/detail_request.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';
import 'package:tirtaasri_app/utils/navigation.dart';

class ListRequestPage extends StatefulWidget {
  const ListRequestPage({super.key, this.onTapItem, required this.user});

  final Function()? onTapItem;
  final dynamic user;

  @override
  State<ListRequestPage> createState() => _ListRequestPageState();
}

class _ListRequestPageState extends State<ListRequestPage> {
  List<dynamic>? _listRequest;
  List<dynamic>? _listUser;
  List<dynamic>? _listRequestWithUser;

  void getDataRequest() {
    DatabaseReference requestRef = FirebaseDatabase.instance.ref('request/');
    requestRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot;
      var listRequest =
          snapshotToList(data).where((e) => e['is_updated']).toList();
      if (mounted) {
        setState(() {
          _listRequest = listRequest;
        });
      }
    });
  }

  void getDataUsers() {
    DatabaseReference usersRef = FirebaseDatabase.instance.ref('user/');
    usersRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot;
      var listUser = snapshotToList(data);
      if (mounted) {
        setState(() {
          _listUser = listUser;
          mappingData();
        });
      }
    });
  }

  void mappingData() {
    // List<dynamic>? mappedData;
    var mappedData = _listRequest?.map((request) {
      var filterUserByRequest = _listUser
          ?.where((user) => user['username'] == request['agent_name'])
          .toList()
          .map((item) {
        item['request_stock'] = request['stock'];
        return item;
      }).toList();
      return filterUserByRequest;
    }).toList();
    var flattenedList = mappedData?.expand((innerList) => innerList!).toList();
    debugPrint("mapped data ${jsonEncode(flattenedList)}");
    setState(() {
      _listRequestWithUser = flattenedList;
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
    getDataRequest();
    getDataUsers();
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
                  text: "Total Request : ${_listRequestWithUser?.length??0} Galon",
                  color: AppColors.primaryColor,
                  style: AppStyles.regular10),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          (_listRequestWithUser != null)
              ? Column(
                  children: _listRequestWithUser!
                      .map((e) => ItemNotification(
                            user: e,
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
      {super.key, this.onTap, this.user});

  final dynamic user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    debugPrint("user ${jsonEncode(user)}");
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
                Badge(
                  child: CustomText(
                      text: "${user['name']}",
                      color: AppColors.primaryColor,
                      style: AppStyles.regular14),
                ),
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
                text: "${user['request_stock']} Galon",
                color: AppColors.primaryColor,
                style: AppStyles.regular14),
          ],
        ),
      ),
    );
  }
}
