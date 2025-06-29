import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  /// Call this before using any other method
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save string
  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Save bool
  static Future<bool> saveBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Save int
  static Future<bool> saveInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  // Get string
  static String? getString(String key) {
    return _prefs.getString(key);
  }
  

  // Get bool
  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Get int
  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Remove key
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all
  static Future<bool> clear() async {
    return await _prefs.clear();
  }
}
