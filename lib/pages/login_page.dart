import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_button.dart';
import 'package:tirtaasri_app/components/custom_dialog.dart';
import 'package:tirtaasri_app/components/custom_input_text.dart';
import 'package:tirtaasri_app/pages/agent/home_agent.dart';
import 'package:tirtaasri_app/pages/employee/home_employee.dart';
import 'package:tirtaasri_app/pages/owner/home_owner.dart';
import 'package:tirtaasri_app/theme/colors.dart';
import 'package:tirtaasri_app/utils/navigation.dart';
import 'package:tirtaasri_app/utils/preferences_util.dart';
import 'package:tirtaasri_app/utils/strings.dart';

enum User { owner, employee, agent }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  void queryData({required Function(dynamic) user}) async {
    String name = usernameController.text;
    String password = passwordController.text;
    final snapshot = await _ref.child('user/').get();
    Map<Object?, Object?> userData = snapshot.value as Map<Object?, Object?>;
    Map<dynamic, dynamic>? userFound;
    userData.forEach((key, value) {
      final user = value as Map<dynamic, dynamic>;
      if (user["username"] == name) {
        if (user["password"] == password) {
          userFound = user;
        }
      }
    });
    user(userFound);
  }

  void _validateLogin() {
    queryData(user: (userFound) {
      if (userFound != null) {
        if (userFound!['role'] == User.owner.name) {
          // owner
          CustomNavigation.pushAndRemoveUntil(
              context: context,
              destination: HomeOwner(
                user: userFound,
              ));
        } else if (userFound!['role'] == User.agent.name) {
          // agent
          CustomNavigation.pushAndRemoveUntil(
              context: context,
              destination: HomeAgent(
                user: userFound,
              ));
        } else {
          // employee
          CustomNavigation.pushAndRemoveUntil(
              context: context,
              destination: HomeEmployee(
                user: userFound,
              ));
        }
        PreferencesUtil.setString(Strings.kUserLogin, jsonEncode(userFound));
      } else {
        CustomDialog(
            title: 'Gagal Login',
            description: 'Username/Password tidak sesuai',
            textButton: 'OK',
            onOkButtonPressed: () {
              Navigator.pop(context);
            }).show(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Image.asset("assets/png/tirtaasri_logo.png"),
          ),
          Center(
            child: SvgPicture.asset("assets/svg/login_img.svg"),
          ),
          const SizedBox(
            height: 22,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomInputText(
              text: "Username",
              controller: usernameController,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomInputText(
              text: "Password",
              controller: passwordController,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomButtonElevation(
                onPressed: () {
                  _validateLogin();
                },
                width: double.infinity,
                textColor: AppColors.white100,
                backgroundColor: AppColors.primaryColor,
                text: "Login"),
          )
        ],
      )),
    );
  }
}
