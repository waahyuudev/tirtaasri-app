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
  late List<dynamic> _listTransaction;
  late List<dynamic> _listRequest;

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void _getTransactions() async {
    DataSnapshot snapshot;
    _listTransaction = [];
    _listRequest = [];

    if (widget.user['role'] == User.employee.name) {
      snapshot = await _ref.child('request/').get();

      setState(() {
        if (snapshot.exists) {
          _listRequest = snapshotToList(snapshot);
          _listRequest =
              _listRequest.map((e) => {"requests": _listRequest}).toList();
          debugPrint("list trx : ${jsonEncode(_listRequest)}");
          debugPrint("list trx length : ${_listRequest.length}");
        } else {
          debugPrint("requests not found");
        }
      });
    } else {
      snapshot = await _ref.child('transactions/').get();

      setState(() {
        if (snapshot.exists) {
          _listTransaction = snapshotToList(snapshot);
          _listTransaction = _listTransaction
              .map((e) => {
                    "created_date": e['created_date'],
                    "transactions": _listTransaction
                        .where((k) => k['created_date'] == e['created_date'])
                        .toList()
                  })
              .toList();
          debugPrint("list trx ${jsonEncode(_listTransaction)}");
          debugPrint("list trx ${_listTransaction.length}");
        } else {
          debugPrint("transactions not found");
        }
      });
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
        child: (_listTransaction.isNotEmpty)
            ? ListView(
                children: _listTransaction
                    .map((e) => ItemTransactions(
                          data: e,
                          user: widget.user,
                        ))
                    .toList(),
              )
            : (_listRequest.isNotEmpty)
                ? ListView(
                    children: _listRequest
                        .map((e) => ItemTransactions(
                              data: e,
                              user: widget.user,
                            ))
                        .toList(),
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
    // List<dynamic> transactions = data['transactions'];
    List<dynamic> requests = data['requests'];

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.greyBgColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomText(
            text: "data['created_date']",
            color: AppColors.greyText,
            style: AppStyles.bold14,
            align: TextAlign.left,
          ),
        ),
        Column(
          children: requests
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
                                  text: trx['agent_name'],
                                  color: AppColors.primaryColor,
                                  style: AppStyles.bold16)
                              : Container(),
                          CustomText(
                              text: "${trx['stock']} Galon",
                              color: AppColors.primaryColor,
                              style: AppStyles.bold16),
                          CustomText(
                              text: "Rp ${trx['amount']}",
                              color: AppColors.primaryColor,
                              style: AppStyles.bold12),
                        ],
                      ),
                      // const Spacer(),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     CustomText(
                      //         text: (trx['status'].toString().toLowerCase() ==
                      //                 "paid")
                      //             ? "Berhasil"
                      //             : "Belum dibayar",
                      //         color: Colors.green,
                      //         style: AppStyles.bold14),
                      //     CustomText(
                      //         text: trx['created_time'],
                      //         color: AppColors.primaryColor,
                      //         style: AppStyles.bold12),
                      //   ],
                      // )
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
