
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../network/provider/auth_provider.dart';
import '../widgets/loading.dart';
import 'home/home_screen.dart';
import 'login/login_screen.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangeProvider);

    return authState.when(
      data: (user) {
        if (user != null) return const HomeScreen();
        return const LoginScreen();
      },
      error: (e, stacktrace) => const LoginScreen(),
      loading: () => const AnimationLoading(size: 50),
    );
  }
}