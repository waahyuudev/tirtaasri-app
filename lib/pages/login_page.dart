import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_button.dart';
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
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  List<dynamic>? listUser;

  void _getUser() async {
    final snapshot = await ref.child('users/').get();
    if (snapshot.exists) {
      listUser = jsonDecode(jsonEncode(snapshot.value));
      debugPrint("username ${listUser?[0]['username']}");
    } else {
      debugPrint("user not found");
    }
  }

  void _validateUser() {
    if (listUser != null) {
      String username = usernameController.text;
      String password = passwordController.text;
      var user = listUser
          ?.where((element) =>
              element['username'] == username &&
              element['password'] == password)
          .first;
      if (user != null) {
        if (user['role'] == User.owner.name) {
          // owner
          CustomNavigation.pushAndRemoveUntil(
              context: context, destination: HomeOwner(user: user,));
        } else if (user['role'] == User.agent.name) {
          // agent
          CustomNavigation.pushAndRemoveUntil(
              context: context, destination: HomeAgent(user: user,));
        } else {
          // employee
          CustomNavigation.pushAndRemoveUntil(
              context: context, destination: HomeEmployee(user: user,));
        }
        PreferencesUtil.setString(Strings.kUserLogin, jsonEncode(user));
      }
    } else {
      debugPrint("data not found");
    }
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SafeArea(
          child: Column(
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
                  _validateUser();
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
