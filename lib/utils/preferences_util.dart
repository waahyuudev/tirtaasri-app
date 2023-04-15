import 'package:shared_preferences/shared_preferences.dart';
import 'package:tirtaasri_app/utils/strings.dart';

class PreferencesUtil {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<void> init() async {
    _prefsInstance = await _instance;
  }

  static String getString(String key, {String? defValue}) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static void setString(String key, String value) async {
    _prefsInstance?.setString(key, value);
  }

  static void setSameString(String key, String value) async {
    if (_prefsInstance?.getString(key) != null) {
      _prefsInstance?.remove(key);
    }
    _prefsInstance?.setString(key, value);
  }

  static int getInt(String key, {int? defValue}) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }

  static void setInt(String key, int value) async {
    _prefsInstance?.setInt(key, value);
  }

  static bool getBool(String key, [var defValue]) {
    return _prefsInstance?.getBool(key) ?? defValue ?? false;
  }

  static void setBool(String key, var value) async {
    _prefsInstance?.setBool(key, value ?? false);
  }

  static bool hasLogin() {
    return getString(Strings.kUserLogin, defValue: "") != "";
  }

  static void remove({required String key}) async {
    _prefsInstance?.remove(key);
  }

  static void clearAll() async {
    _prefsInstance?.clear();
  }
}
