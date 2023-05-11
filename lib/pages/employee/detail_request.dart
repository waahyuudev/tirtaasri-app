import 'dart:convert';

import 'package:flutter/material.dart';
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
  int unpaidTotal = 0;

  void addTransactionPaid() async {
    var request = {
      "agen_id": widget,
      "employee_id": widget,
      "quantity": "7",
      "alamat": "Jl Bouroq",
      "created_date": "1 Feb 2023",
      "created_time": "17:24",
      "amount": 14000,
      "status": "Paid"
    };
  }

  void addTransactionUnPaid() async {
    var request = {
      "agen": widget,
      "employee_id": widget,
      "quantity": "7",
      "alamat": "Jl Bouroq",
      "created_date": "1 Feb 2023",
      "created_time": "17:24",
      "amount": 14000,
      "status": "UnPaid"
    };
  }

  @override
  void initState() {
    paidTotal = int.parse(widget.user['stock']);
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
                    text: "Rp, 35.000",
                    color: AppColors.primaryColor,
                    style: AppStyles.bold14),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: CustomText(
                    text: "Galon Piutang",
                    color: AppColors.primaryColor,
                    style: AppStyles.bold14),
              ),
              /*CustomText(
                  text: "2",
                  color: AppColors.primaryColor,
                  style: AppStyles.bold16),*/
              CustomCountTotal(
                total: (value) {
                  setState(() {
                    unpaidTotal = value;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: CustomText(
                    align: TextAlign.end,
                    text: "Rp, 35.000",
                    color: AppColors.primaryColor,
                    style: AppStyles.bold14),
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
                            onSaved: () {
                              // todo for add transaction
                              addTransactionPaid();
                              addTransactionUnPaid();
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
  const DialogConfirmation({super.key, required this.onSaved});

  final Function() onSaved;

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
