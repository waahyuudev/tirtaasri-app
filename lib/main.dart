import 'package:flutter/material.dart';
import 'package:tirtaasri_app/pages/agent/home_agen.dart';
import 'package:tirtaasri_app/pages/employee/home_employee.dart';
import 'package:tirtaasri_app/pages/login_page.dart';
import 'package:tirtaasri_app/pages/owner/home_owner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
    home: LoginPage(),);
  }
}
