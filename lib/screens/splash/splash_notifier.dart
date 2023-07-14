import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'splash_state.dart';

class SplashNotifier extends StateNotifier<SplashState> {
  SplashNotifier() : super(const SplashState());

  void changePage(int page) {
    state = state.copyWith(page: page);
  }
}

final splashStateNotifier = StateNotifierProvider<SplashNotifier, SplashState>(
    (ref) => SplashNotifier());
