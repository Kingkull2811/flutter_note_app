import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'network/provider/dark_mode_provider.dart';
import 'routes.dart';
import 'util/app_theme.dart';
import 'util/shared_preferences_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  // static final ValueNotifier<ThemeMode> themeNotifier =
  //     SharedPreferencesStorage().getNightMode()
  //         ? ValueNotifier(ThemeMode.dark)
  //         : ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider).isDarkMode();

    return MaterialApp(
      title: 'Kull Note App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      supportedLocales: L10n.all,
      // locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: AppRoute.main,
    );
    // return ValueListenableBuilder(
    //   valueListenable: themeNotifier,
    //   builder: (BuildContext context, currentMode, _) {
    //
    //   },
    // );
  }
}
