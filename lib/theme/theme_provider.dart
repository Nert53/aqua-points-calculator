import 'package:fina_points_calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  final _currentBrightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  bool _isSystemColorMode = false;
  bool get isSystemColorMode => _isSystemColorMode;

  ThemeProvider() {
    loadTheme();
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSystemColorMode = prefs.getBool('isSystemColorMode') ?? false;

    if (_isSystemColorMode) {
      themeData = _currentBrightness == Brightness.dark ? darkMode : lightMode;
      return;
    }

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

  void setSystemColorMode(bool value) {
    _isSystemColorMode = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isSystemColorMode', value);
    });
    if (value) {
      themeData = _currentBrightness == Brightness.dark ? darkMode : lightMode;
    }
    notifyListeners();
  }

  void setDarkMode(bool value) {
    themeData = value ? darkMode : lightMode;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarkMode', value);
    });
    notifyListeners();
  }

  bool isDarkMode() {
    return themeData == darkMode;
  }
  
  /*
  ! not used

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
  */
}
