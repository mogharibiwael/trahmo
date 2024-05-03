

import 'package:shared_preferences/shared_preferences.dart';

class LocalData{

 static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static Future<void> saveListData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, [value]);
  }

 static Future<String> getData(String key) async {
   final prefs = await SharedPreferences.getInstance();
   return prefs.getString(key) ?? '';
 }
 static Future<String> getListData(String key) async {
   final prefs = await SharedPreferences.getInstance();
   return prefs.getString(key) ?? '';
 }
}
