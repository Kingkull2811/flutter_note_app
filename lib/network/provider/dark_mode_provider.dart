import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/shared_preferences_storage.dart';

class DarkModeNotifier extends ChangeNotifier {
  DarkModeNotifier();

  bool isDarkMode() => SharedPreferencesStorage().getNightMode();

  void setDarkMode(bool value) async {
    await SharedPreferencesStorage().setNightMode(value);
    notifyListeners();
  }
}

final darkModeProvider = ChangeNotifierProvider(
  (ref) => DarkModeNotifier(),
);
