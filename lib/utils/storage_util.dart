import 'package:chat_keluarga/utils/global_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  // Method untuk menyimpan token ke SharedPreferences
  static Future<bool> saveToken(String token) async {
    if (token.isEmpty) {
      return false;
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(GlobalKeys.authKey, token);
      return true;
    } catch (e) {
      debugPrint('error save token = ${e.toString()}');
      return false;
    }
  }

  // Method untuk mendapatkan token dari SharedPreferences
  static Future<String?> getToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(GlobalKeys.authKey);
    } catch (e) {
      debugPrint('error get token = ${e.toString()}');
      return null;
    }
  }

  // Method untuk menghapus token dari SharedPreferences
  static Future<bool> deleteToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(GlobalKeys.authKey);
      return true;
    } catch (e) {
      debugPrint('error delete token = ${e.toString()}');
      return false;
    }
  }
}
