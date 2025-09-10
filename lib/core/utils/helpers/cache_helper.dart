import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _prefs;

  /// Call this before using any other method
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// ---------- SAVE ----------
  static Future<bool> saveString(String key, String value) async =>
      await _prefs.setString(key, value);

  static Future<bool> saveBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  static Future<bool> saveInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  static Future<bool> saveDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  static Future<bool> saveStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  /// ---------- GET ----------
  static String? getString(String key) => _prefs.getString(key);

  static bool? getBool(String key) => _prefs.getBool(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  /// ---------- CHECK ----------
  static bool contains(String key) => _prefs.containsKey(key);

  /// ---------- REMOVE / CLEAR ----------
  static Future<bool> remove(String key) async => await _prefs.remove(key);

  static Future<bool> clear() async => await _prefs.clear();

  static getProviderData() {}

  /// ---------- USER ROLE ----------
  static Future<void> saveRole(String role) async {
    await _prefs.setString('user_role', role);
  }

  static String? getRole() {
    return _prefs.getString('user_role');
  }

  static Future<void> clearRole() async {
    await _prefs.remove('user_role');
  }
}
