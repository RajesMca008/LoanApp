import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static saveSharedPreferenceInString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    // set value
    prefs.setString(key, value);
  }

  static Future<String> getSharedPreferenceFromString(String key) async {
    final prefs = await SharedPreferences.getInstance();
// Try reading data from the counter key. If it does not exist, return 0.
    return prefs.getString(key) ?? "";
  }

  static Future<String> getUserName() async {
    return getSharedPreferenceFromString("UserName");
  }

  static Future<String> getMobileNumber() async {
    return getSharedPreferenceFromString("MobileNumber");
  }

  static Future<String> getEmailId() async {
    return getSharedPreferenceFromString("EmailId");
  }
}
