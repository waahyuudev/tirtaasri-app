import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/pages/login_page.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key, this.user});

  final dynamic user;

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  List<dynamic>? _listTransaction;

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void _getTransactions() async {
    final snapshot = await _ref.child('transactions/').get();
    setState(() {
      if (snapshot.exists) {
        _listTransaction = jsonDecode(jsonEncode(snapshot.value));
        _listTransaction = _listTransaction
            ?.map((e) => {
          "created_date": e['created_date'],
          "transactions": _listTransaction
              ?.where((k) => k['created_date'] == e['created_date'])
              .toList()
        })
            .toList();
        debugPrint("list trx ${jsonEncode(_listTransaction)}");
        debugPrint("list trx ${_listTransaction?.length}");
      } else {
        debugPrint("transactions not found");
      }
    });
  }

  @override
  void initState() {
    _getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        withLeading: true,
        centerTitle: true,
        titleWidget: Image.asset(
          "assets/png/app_bar_logo.png",
        ),
        onBack: () => Navigator.pop(context),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/svg/uiw_date.svg"))
        ],
      ),
      body: SafeArea(
        child: (_listTransaction != null)
            ? ListView(
                children: _listTransaction!
                    .map((e) => ItemTransactions(
                          data: e,
                          user: widget.user,
                        ))
                    .toList() /*[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.greyBgColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: CustomText(
                    text: "07 Feb 2023",
                    color: AppColors.greyText,
                    style: AppStyles.bold14,
                    align: TextAlign.left,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      color: AppColors.aquaColor,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (widget.user['role'] == User.agent.name)
                                  ? CustomText(
                                      text: widget.user['agentName'],
                                      color: AppColors.primaryColor,
                                      style: AppStyles.bold16)
                                  : Container(),
                              CustomText(
                                  text: "2 Galon",
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold16),
                              CustomText(
                                  text: "Rp 14.000",
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold12),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                  text: "Berhasil",
                                  color: Colors.green,
                                  style: AppStyles.bold14),
                              CustomText(
                                  text: "17.24",
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold12),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      color: AppColors.aquaColor,
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: "2 Galon",
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold16),
                              CustomText(
                                  text: "Rp 14.000",
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold12),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                  text: "Berhasil",
                                  color: Colors.green,
                                  style: AppStyles.bold14),
                              CustomText(
                                  text: "17.24",
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold12),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            // Column(
            //   children: [
            //     Container(
            //       width: double.infinity,
            //       color: AppColors.greyBgColor,
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //       child: CustomText(
            //         text: "07 Feb 2023",
            //         color: AppColors.greyText,
            //         style: AppStyles.bold14,
            //         align: TextAlign.left,
            //       ),
            //     ),
            //     Container(
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 16, vertical: 10),
            //       color: AppColors.aquaColor,
            //       child: Row(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               CustomText(
            //                   text: "2 Galon",
            //                   color: AppColors.primaryColor,
            //                   style: AppStyles.bold16),
            //               CustomText(
            //                   text: "Rp 14.000",
            //                   color: AppColors.primaryColor,
            //                   style: AppStyles.bold12),
            //             ],
            //           ),
            //           const Spacer(),
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             crossAxisAlignment: CrossAxisAlignment.end,
            //             children: [
            //               CustomText(
            //                   text: "Berhasil",
            //                   color: Colors.green,
            //                   style: AppStyles.bold14),
            //               CustomText(
            //                   text: "17.24",
            //                   color: AppColors.primaryColor,
            //                   style: AppStyles.bold12),
            //             ],
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
          ]*/
                ,
              )
            : Container(),
      ),
    );
  }
}

class ItemTransactions extends StatelessWidget {
  const ItemTransactions({super.key, this.user, required this.data});

  final dynamic user;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    List<dynamic> transactions = data['transactions'];

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.greyBgColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomText(
            text: data['created_date'],
            color: AppColors.greyText,
            style: AppStyles.bold14,
            align: TextAlign.left,
          ),
        ),
        Column(
          children: transactions
              .map(
                (trx) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: AppColors.aquaColor,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (user['role'] == User.agent.name)
                              ? CustomText(
                                  text: user['agentName'],
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold16)
                              : Container(),
                          CustomText(
                              text: "${trx['quantity']} Galon",
                              color: AppColors.primaryColor,
                              style: AppStyles.bold16),
                          CustomText(
                              text: "Rp ${trx['amount']}",
                              color: AppColors.primaryColor,
                              style: AppStyles.bold12),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                              text: (trx['status'].toString().toLowerCase() ==
                                      "paid")
                                  ? "Berhasil"
                                  : "Belum dibayar",
                              color: Colors.green,
                              style: AppStyles.bold14),
                          CustomText(
                              text: trx['created_time'],
                              color: AppColors.primaryColor,
                              style: AppStyles.bold12),
                        ],
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
