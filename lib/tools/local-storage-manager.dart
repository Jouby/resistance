import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageManager extends StatelessWidget {
  static Future<dynamic> getLocaleStorageData(String key,
      [dynamic defaultValue]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? (defaultValue) ?? 0;
  }

  static Future<dynamic> getListLocaleStorageData(String key,
      [dynamic defaultValue]) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? (defaultValue) ?? 0;
  }

  static void setLocaleStorageData(String key, Object value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case int:
        prefs.setInt(key, value);
        break;
      case String:
        prefs.setString(key, value);
        break;
      case bool:
        prefs.setBool(key, value);
        break;
      case double:
        prefs.setDouble(key, value);
        break;
      default:
        prefs.setString(key, value.toString());
        break;
    }
  }

    static void setListLocaleStorageData(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }
}
