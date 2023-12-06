import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class SharedPreferencesStorage {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// -------App Info
  setFirstTimeOpenApp(bool value) async => await _prefs.setBool(firstTimeOpenApp, value);

  bool getFirstTimeOpenApp() => _prefs.getBool(firstTimeOpenApp) ?? false;

  Future<void> setNightMode(bool value) async => await _prefs.setBool(nightModeKey, value);

  bool getNightMode() => _prefs.getBool(nightModeKey) ?? false;
}
