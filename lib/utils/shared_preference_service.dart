import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static late SharedPreferences _prefs;

  // initialize ONLY ONCE
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // color mode preferences
  static bool isSystemColorMode() {
    return _prefs.getBool('isSystemColorMode') ?? false;
  }

  static bool isDarkMode() {
    return _prefs.getBool('isDarkMode') ?? false;
  }

  static Future<bool> setIsDarkMode(bool isDark) {
    return _prefs.setBool('isDarkMode', isDark);
  }

  static Future<bool> setSystemColorMode(bool value) {
    return _prefs.setBool('isSystemColorMode', value);
  }

  // junior mode preferences
  static bool isJuniorMode() {
    return _prefs.getBool('isJuniorMode') ?? false;
  }

  static Future<bool> setIsJuniorMode(bool value) {
    return _prefs.setBool('isJuniorMode', value);
  }

  // feature dialog preferences
  static int getNewFeatureCount(String nameOfFeature) {
    return _prefs.getInt(nameOfFeature) ?? 0;
  }

  static Future<bool> setNewFeatureCount(String nameOfFeature, int value) {
    return _prefs.setInt(nameOfFeature, value);
  }

  // language preferences
  static String getLanguageCode() {
    return _prefs.getString('languageCode') ?? 'en';
  }

  static Future<bool> setLanguageCode(String languageCode) {
    return _prefs.setString('languageCode', languageCode);
  }
}
