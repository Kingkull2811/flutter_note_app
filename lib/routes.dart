import 'package:flutter/material.dart';

import 'screens/auth_checker.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/setting/setting_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'util/shared_preferences_storage.dart';

class AppRoute {
  static const main = '/';
  static const home = '/home';
  static const auth = '/auth';
  static const settings = '/settings';
  static const login = '/auth/login';
  static const signup = '/auth/signup';
  static const profile = '/auth/profile';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.main:
        return MaterialPageRoute(builder: (context) {
          final bool isFirstTimeOpenApp =
              SharedPreferencesStorage().getFirstTimeOpenApp();
          return isFirstTimeOpenApp
              ? const AuthChecker()
              : const SplashScreen();
        });
      case AppRoute.auth:
        return MaterialPageRoute(builder: (context) => const AuthChecker());

      case AppRoute.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case AppRoute.settings:
        return MaterialPageRoute(builder: (context) => const SettingScreen());

      case AppRoute.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case AppRoute.signup:
        // final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => const SignUpScreen()
            // MobileChatScreen(
            //       isGroupChat: arguments['isGroupChat'],
            //       name: arguments['name'],
            //       recieverUserId: arguments['recieverUserId'],
            //       profilePic: arguments['profilePic'],
            //     ),
            );
      // case AppRoute.profile:
      //   return MaterialPageRoute(
      //     builder: (context) => const ProfileScreen(),
      //   );

      default:
        return MaterialPageRoute(builder: (context) => const AuthChecker());
    }
  }
}
