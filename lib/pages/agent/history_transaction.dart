import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/theme/styles.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key, this.user});

  final dynamic user;

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  late List<dynamic> _listTransaction;

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void _getTransactions() async {
    DataSnapshot snapshot;
    _listTransaction = [];

    snapshot = await _ref.child('transaction/').get();

    setState(() {
      if (snapshot.exists) {
        _listTransaction = snapshotToList(snapshot);
        if (widget.user['role'] == 'agent') {
          var dateKeys =
          _listTransaction.where((e) => e['agent_username'] == widget.user['username']).map((e) => e['created_date']).toSet().toList();
          _listTransaction = dateKeys
              .map((e) => {
            "created_date": e,
            "transactions": _listTransaction
                .where((k) => k['created_date'] == e && k['agent_username'] == widget.user['username'])
                .toList()
          })
              .toList();
        } else {

          var dateKeys =
          _listTransaction.where((e) => e['employee_name'] == widget.user['username']).map((e) => e['created_date']).toSet().toList();
          _listTransaction = dateKeys
              .map((e) => {
            "created_date": e,
            "transactions": _listTransaction
                .where((k) => k['created_date'] == e && k['employee_name'] == widget.user['username'])
                .toList()
          })
              .toList();
        }
      } else {
        debugPrint("transactions not found");
      }
    });
    debugPrint("listTransaction ${jsonEncode(_listTransaction)}");
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
        child:
            ListView(
          children: _listTransaction
              .map((e) => ItemTransactions(
                    data: e,
                    user: widget.user,
                  ))
              .toList(),
        ),
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
    // List<dynamic> requests = data['requests'];

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.greyBgColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomText(
            text: "${data['created_date']}",
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
                      CustomText(
                          text: "${trx['created_time']}",
                          color: AppColors.primaryColor,
                          style: AppStyles.bold12)
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
