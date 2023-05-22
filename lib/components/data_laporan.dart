import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tirtaasri_app/components/custom_text.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Container(
            width: 402,
            height: 43,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
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
                      child: Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 10,),
                    CustomText(
                        text: "Selected Text",
                        color: AppColors.primaryColor,
                        style: AppStyles.regular10),
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         width: 201,
                //         height: 51,
                //         margin: EdgeInsets.only(right: 10),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.blue.withOpacity(0.5),
                //               blurRadius: 2,
                //               offset: Offset(0, 1),
                //             ),
                //           ],
                //         ),
                //         child: Center(
                //           child: Text(
                //             'Laporan Penjualan',
                //             style: TextStyle(
                //               color: Colors.blue,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         width: 201,
                //         height: 51,
                //         margin: EdgeInsets.only(left: 10, right: 10),
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           boxShadow: [
                //             BoxShadow(
                //               color: Colors.blue.withOpacity(0.5),
                //               blurRadius: 2,
                //               offset: Offset(0, 1),
                //             ),
                //           ],
                //         ),
                //         child: Center(
                //           child: Text(
                //             'Laporan Piutang',
                //             style: TextStyle(
                //               color: Colors.blue,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10),
                // Container(
                //   width: 410,
                //   height: 43,
                //   margin: EdgeInsets.only(left: 4),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.blue.withOpacity(0.5),
                //         blurRadius: 2,
                //         offset: Offset(0, 1),
                //       ),
                //     ],
                //   ),
                //   child: Center(
                //     child: Text(
                //       'Cetak PDF',
                //       style: TextStyle(
                //         color: Colors.blue,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
          ),
        ],
    );
  }
}
