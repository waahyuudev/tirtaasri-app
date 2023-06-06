import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tirtaasri_app/components/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';
import 'custom_appbar.dart';

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
  DateTime selectedDate = DateTime.now(); // Tanggal default saat belum dipilih
  DateTime selectedDate2 = DateTime.now(); // Tanggal default saat belum dipilih

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? pickedDate2 = await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate2 != null && pickedDate2 != selectedDate2) {
      setState(() {
        selectedDate2 = pickedDate2;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Image.asset(
          "assets/png/app_bar_logo.png",
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
              children: [
                SizedBox(height: 10),
                //Container Pilih Tanggal
                InkWell(
                  onTap: () {
                    _selectDate(context);
                    _selectDate2(context);
                  },
                  child: Container(
                    width: 402,
                    height: 43,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                        Container(
                          width: 27,
                          height: 27,
                          child: SvgPicture.asset("assets/svg/uiw_date.svg"),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: _formatDate(selectedDate2),
                                  color: AppColors.primaryColor,
                                  style: AppStyles.regular10,
                                ),
                                CustomText(
                                  text: ' - ',
                                  color: AppColors.primaryColor,
                                  style: AppStyles.regular10,
                                ),
                                CustomText(
                                  text: _formatDate(selectedDate), // Ganti dengan variabel tanggal kedua yang sesuai
                                  color: AppColors.primaryColor,
                                  style: AppStyles.regular10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //Container Button penjualan dan piutang
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: 176,
                          height: 51,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                              Expanded(
                                child: Center(
                                  child: CustomText(
                                      text: 'Laporan Penjualan',
                                      color: AppColors.primaryColor,
                                      style: AppStyles.regular11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: 176,
                          height: 51,
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                              Expanded(
                                child: Center(
                                  child: CustomText(
                                      text: 'Laporan Piutang',
                                      color: AppColors.primaryColor,
                                      style: AppStyles.regular11),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                //Container Button Cetak Pdf
                InkWell(
                  onTap: (){},
                  child: Container(
                    width: 402,
                    height: 43,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
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
                      child: Container(
                        width: 27,
                        height: 27,
                        child:  SvgPicture.asset("assets/svg/pdf.svg")
                      ),
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
