import 'dart:convert';
import 'package:newdow_customer/features/auth/model/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/profile/model/userModel.dart';
// your model file

class AuthStorage {
  static const String user = 'user';

  /// ✅ Save OtpVerifyResponse to SharedPreferences
  static Future<void> saveUserInPrefs(UserModel response) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(response.toJson());
    await prefs.setString(user, jsonString);
  }


  static Future<UserModel?> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(user);
    if (jsonString == null) return null;

    final Map<String, dynamic> data = jsonDecode(jsonString);
    return UserModel.fromJson(data);
  }

  /// ✅ Clear saved data
  static Future<void> clearOnlyUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(user);

  }static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(user);
    await prefs.remove("accessToken");

  }

  /// ✅ Get access token quickly
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
     await prefs.setString('accessToken',token);
  }

  /// ✅ Check if user is logged in (token exists)
  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
