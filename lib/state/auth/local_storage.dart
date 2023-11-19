import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> storeToken(String token) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return await preferences.setString("x-auth-token", token);
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getToken() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String? token = preferences.getString("x-auth-token");
      return token;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteToken() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return await preferences.remove("x-auth-token");
    } catch (e) {
      return false;
    }
  }

  LocalStorage._();
}
