import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tirtaasri_app/components/custom_button.dart';
import 'package:tirtaasri_app/components/custom_input_text.dart';
import 'package:tirtaasri_app/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

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
          const SizedBox(height: 22,),
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
            child: const CustomButtonElevation(
              width: double.infinity,
                textColor: AppColors.white100, backgroundColor: AppColors.primaryColor, text: "Login"),
          )
        ],
      )),
    );
  }
}
