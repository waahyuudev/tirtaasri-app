import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tirtaasri_app/components/custom_button.dart';
import 'package:tirtaasri_app/components/custom_count_total.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/employee/home_employee.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/utils/dialog.dart';
import 'package:tirtaasri_app/utils/navigation.dart';
import 'package:tirtaasri_app/utils/preferences_util.dart';
import 'package:tirtaasri_app/utils/strings.dart';

import '../../theme/styles.dart';

class DetailRequest extends StatefulWidget {
  const DetailRequest({super.key, this.data, this.user});

  final dynamic user;
  final dynamic data;

  @override
  State<DetailRequest> createState() => _DetailRequestState();
}

class _DetailRequestState extends State<DetailRequest> {
  int paidTotal = 0;

  void updateStokGalon() async {
    dynamic requestData;
    String? reqKey;
    final ref = FirebaseDatabase.instance.ref();
    DataSnapshot dataSnapshot = await ref.child("request").get();

    if (dataSnapshot.value != null) {
      Map<dynamic, dynamic>? values = dataSnapshot.value as Map?;
      values?.forEach((key, item) {
        debugPrint("item ${item.runtimeType}");
        if (item['agent_name'] == widget.data['username']) {
          requestData = item;
          reqKey = key;
        }
      });
    }

    if (requestData != null) {
      await ref.update({
        "request/$reqKey/stock": paidTotal,
        "request/$reqKey/is_updated": false,
      });
    } else {
      requestData = {
        "agent_name": widget.user['username'],
        "stock": paidTotal,
        "is_updated": false
      };
      final newPostKey = ref.child('/request/').push().key;
      final Map<String, Map> updates = {};
      updates['/request/$newPostKey'] = requestData;
      ref.update(updates);
    }
  }

  void addTransaction() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedTime = DateFormat('HH:mm:ss').format(now);
    final ref = FirebaseDatabase.instance.ref();
    var request = {
      "agent_username": widget.data['username'],
      "employee_name": widget.user['username'],
      "quantity": paidTotal,
      "alamat": widget.user['address'],
      "created_date": formattedDate,
      "created_time": formattedTime,
      "amount": 7000 * paidTotal,
    };

    final newPostKey = ref.child('/request/').push().key;
    final Map<String, Map> updates = {};
    updates['/transaction/$newPostKey'] = request;
    ref.update(updates);
  }

  @override
  void initState() {
    paidTotal = widget.user['stock'] != null ? int.parse(widget.user['stock']) : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          color: AppColors.greyBgColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: CustomText(
                    text: "Galon Terjual",
                    color: AppColors.primaryColor,
                    style: AppStyles.bold14),
              ),
              CustomCountTotal(
                total: (value) {
                  setState(() {
                    paidTotal = value;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: CustomText(
                    align: TextAlign.end,
                    text: "Rp, ${7000 * paidTotal}",
                    color: AppColors.primaryColor,
                    style: AppStyles.bold14),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomButtonElevation(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          textColor: AppColors.primaryColor,
                          backgroundColor: AppColors.aquaMiddleColor,
                          text: "Batal")),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomButtonElevation(
                        onPressed: () {
                          CustomDialog.show(context, DialogConfirmation(
                            total: paidTotal,
                            onSaved: () {
                              // todo for add transaction
                              addTransaction();
                              updateStokGalon();
                              var user =
                                  PreferencesUtil.getString(Strings.kUserLogin);
                              CustomNavigation.pushAndRemoveUntil(
                                  context: context,
                                  destination: HomeEmployee(
                                    user: jsonDecode(user),
                                  ));
                            },
                          ));
                        },
                        textColor: AppColors.primaryColor,
                        backgroundColor: AppColors.aquaMiddleColor,
                        text: "Simpan"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DialogConfirmation extends StatelessWidget {
  const DialogConfirmation({super.key, required this.onSaved, required this.total});

  final Function() onSaved;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
            text: "APAKAH ANDA YAKIN DATA SUDAH BENAR ?",
            color: AppColors.primaryColor,
            style: AppStyles.bold14),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            SizedBox(width: 100, child: CustomText(text: "Permintaan", color: AppColors.primaryColor, style: AppStyles.regular16),),
            Expanded(child: CustomText(text: "$total", color: AppColors.primaryColor, style: AppStyles.regular16)),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 100, child: CustomText(text: "Total Bayar", color: AppColors.primaryColor, style: AppStyles.regular16),),
            Expanded(child: CustomText(text: "Rp ${total * 7000}", color: AppColors.primaryColor, style: AppStyles.regular16)),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: CustomButtonElevation(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textColor: AppColors.primaryColor,
                    backgroundColor: AppColors.aquaMiddleColor,
                    text: "Batal")),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomButtonElevation(
                  onPressed: onSaved,
                  textColor: AppColors.primaryColor,
                  backgroundColor: AppColors.aquaMiddleColor,
                  text: "Simpan"),
            )
          ],
        )
      ],
    );
  }
}
