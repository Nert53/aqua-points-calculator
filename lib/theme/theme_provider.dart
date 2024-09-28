import 'package:fina_points_calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;

  ThemeProvider() {
    loadTheme();
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDarkMode') ?? false;
    themeData = isDark ? darkMode : lightMode;
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarMode', themeData == darkMode);
    });
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarkMode', themeData == darkMode);
    });
    notifyListeners();
  }

  bool isDarkMode() {
    return themeData == darkMode;
  }
}
