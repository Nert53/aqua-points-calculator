import 'package:flutter/foundation.dart';
import 'package:fina_points_calculator/utils/shared_preference_service.dart';

// Listen to this to rebuild UI when junior mode is toggled.
class JuniorModeNotifier extends ChangeNotifier {
  static final JuniorModeNotifier _instance = JuniorModeNotifier._internal();

  factory JuniorModeNotifier() {
    return _instance;
  }

  JuniorModeNotifier._internal();

  bool get isJuniorMode => PreferencesService.isJuniorMode();

  Future<void> setJuniorMode(bool value) async {
    await PreferencesService.setIsJuniorMode(value);
    notifyListeners();
  }
}
