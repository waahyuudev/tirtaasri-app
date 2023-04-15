import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';

class HistoryTransaction extends StatelessWidget {
  const HistoryTransaction({super.key});

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
        child: Container(

        ),
      ),
    );
  }
}
