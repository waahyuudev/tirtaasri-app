import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tirtaasri_app/firebase_options.dart';
import 'package:tirtaasri_app/pages/agent/home_agent.dart';
import 'package:tirtaasri_app/pages/employee/home_employee.dart';
import 'package:tirtaasri_app/pages/login_page.dart';
import 'package:tirtaasri_app/pages/owner/home_owner.dart';
import 'package:tirtaasri_app/utils/preferences_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PreferencesUtil.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
