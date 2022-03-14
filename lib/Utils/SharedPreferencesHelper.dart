import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String userId = "userId";
  static final String authToken = "authToken";
  static final String userJson = "userJson";
  static final String email = "email";
  static final String role = "role";

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId);
  }

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(email);
  }

  static Future<String> getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(role);
  }

  static Future<bool> setEmail(String value) async {
    print(value);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(email, value);
  }

  static Future<bool> setRole(String value) async {
    print(value);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(role, value);
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userId, value);
  }

  static Future<String> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(authToken);
  }

  static Future<bool> setAuthToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(authToken, value);
  }

  static Future<String> getUserJson() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userJson);
  }

  static Future<bool> setUserJson(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userJson, value);
  }

  static void removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userJson);
  }
}
