import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../util/shared_preferences_storage.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(false);

  void changeMode() async {
    state = !state;
    await SharedPreferencesStorage().setNightMode(state);
  }

  void getState() => state = SharedPreferencesStorage().getNightMode();
}

final darkModeStateProvider = StateProvider<ThemeMode>((ref) {
  return SharedPreferencesStorage().getNightMode()
      ? ThemeMode.dark
      : ThemeMode.light;
});
