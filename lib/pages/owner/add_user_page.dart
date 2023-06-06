import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tirtaasri_app/components/custom_appbar.dart';
import 'package:tirtaasri_app/pages/owner/components/custom_dropdown.dart';
import 'package:tirtaasri_app/pages/owner/home_owner.dart';

import '../../components/custom_button.dart';
import '../../components/custom_input_text.dart';
import '../../theme/colors.dart';
import '../../utils/navigation.dart';
import '../../utils/preferences_util.dart';
import '../../utils/strings.dart';
import '../../utils/toast.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  String role = "";

  void addUser() {
    final ref = FirebaseDatabase.instance.ref();
    var request = {
      "name": nameController.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "phoneNumber": phoneNumberController.text,
      "address": addressController.text,
      "role": role,
    };

    final newPostKey = ref.child('/user/').push().key;
    final Map<String, Map> updates = {};
    updates['/user/$newPostKey'] = request;
    ref.update(updates);

    var user = PreferencesUtil.getString(Strings.kUserLogin);
    CustomToast.show(context, "User berhasil ditambah", type: ToastType.success);
    CustomNavigation.pushAndRemoveUntil(
        context: context,
        destination: HomeOwner(
          user: jsonDecode(user),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          onBack: () => Navigator.pop(context),
          withLeading: true,
          titleWidget: Image.asset(
            "assets/png/app_bar_logo.png",
          )),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomInputText(
              text: "Name",
              controller: nameController,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomInputText(
              text: "Phone Number",
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
            ),
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
            child: CustomInputText(
              text: "Alamat",
              controller: addressController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDropdown(
            selected: (value) => setState(() => role = value),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CustomButtonElevation(
                onPressed: () {
                  addUser();
                },
                width: double.infinity,
                textColor: AppColors.white100,
                backgroundColor: AppColors.primaryColor,
                text: "Tambah User"),
          )
        ],
      )),
    );
  }
}
