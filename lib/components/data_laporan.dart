import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tirtaasri_app/utils/toast.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_appbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DataLaporan extends StatefulWidget {
  const DataLaporan({
    super.key,
    required this.user,
  });

  final dynamic user;

  @override
  State<DataLaporan> createState() => _DataLaporanState();
}

class _DataLaporanState extends State<DataLaporan> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != startDate) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != endDate) {
      setState(() {
        endDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  Future<void> generatePDFWithTable() async {
    final DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.child('transaction/').get();
    var originalList = snapshotToList(snapshot);
    List filteredList = originalList.where((item) {
      DateTime createdDate = DateTime.parse(item["created_date"]);
      return createdDate.isAtSameMomentAs(startDate) || createdDate.isAtSameMomentAs(endDate);
    }).toList();

    final pdf = pw.Document();

    final headers = [
      'Waktu Dibuat',
      'Nama Agen',
      'Amount',
      "Jumlah",
      "Nama Karyawan",
      "Nama Karyawan",
      "No. Telepon",
      "Tanggal Dibuat"
          "Alamat"
    ];

    debugPrint("list original ${jsonEncode(originalList)}");
    debugPrint("filteredList original ${jsonEncode(filteredList)}");

    List<List<dynamic>> data = [
      headers,
    ];
    for (var item in filteredList) {
      data.add(item.values.toList());
    }

    final table = pw.Table.fromTextArray(
      headers: headers,
      data: data.sublist(1),
      cellAlignment: pw.Alignment.centerLeft,
      cellStyle: const pw.TextStyle(fontSize: 10),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      border: pw.TableBorder.all(width: 0.5),
      headerDecoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(2),
        color: PdfColors.grey,
      ),
      headerAlignment: pw.Alignment.center,
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            child: table,
          );
        },
      ),
    );

    var formatter = DateFormat('yyyy-MM-dd');
    var now = DateTime.now();

    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    String filePath = '$path/transaction-${formatter.format(now)}.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    CustomToast.show(context, "Laporan berhasil di simpan",
        type: ToastType.success);
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        withLeading: true,
        onBack: () => Navigator.pop(context),
        titleWidget: Image.asset(
          "assets/png/app_bar_logo.png",
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Container Pilih Tanggal
              InkWell(
                onTap: () {},
                child: Container(
                  width: 402,
                  height: 43,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 27,
                        height: 27,
                        child: SvgPicture.asset("assets/svg/uiw_date.svg"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => _selectStartDate(context),
                                child: CustomText(
                                  text: _formatDate(startDate),
                                  color: AppColors.primaryColor,
                                  style: AppStyles.regular10.copyWith(decoration: TextDecoration.underline),
                                ),
                              ),
                              CustomText(
                                text: ' - ',
                                color: AppColors.primaryColor,
                                style: AppStyles.regular10,
                              ),
                              GestureDetector(
                                onTap: () => _selectEndDate(context),
                                child: CustomText(
                                  text: _formatDate(endDate),
                                  color: AppColors.primaryColor,
                                  style: AppStyles.regular10.copyWith(decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Container Button Cetak Pdf
              InkWell(
                onTap: () {
                  generatePDFWithTable();
                },
                child: Container(
                  width: 402,
                  height: 43,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: AppColors.grayColor,
                    borderRadius: BorderRadius.circular(1.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SizedBox(
                        width: 27,
                        height: 27,
                        child: SvgPicture.asset("assets/svg/pdf.svg")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
