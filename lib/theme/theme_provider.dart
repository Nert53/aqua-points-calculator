import 'dart:ui';
import 'package:fina_points_calculator/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  bool _isSystemColorMode = false;
  bool get isSystemColorMode => _isSystemColorMode;

  ThemeProvider() {
    WidgetsBinding.instance.addObserver(this);
    loadTheme();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (_isSystemColorMode) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      themeData = brightness == Brightness.dark ? darkMode : lightMode;
    }
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSystemColorMode = prefs.getBool('isSystemColorMode') ?? false;

    if (_isSystemColorMode) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      themeData = brightness == Brightness.dark ? darkMode : lightMode;
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
      final brightness = PlatformDispatcher.instance.platformBrightness;
      themeData = brightness == Brightness.dark ? darkMode : lightMode;
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
