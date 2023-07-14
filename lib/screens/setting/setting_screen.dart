import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kull_note_app/network/provider/dark_mode_provider.dart';
import 'package:kull_note_app/screens/login/login_state_notifier.dart';

import '../../util/app_theme.dart';
import '../../util/screen_util.dart';
import '../../util/util.dart';

class SettingScreen extends StatefulHookConsumerWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(darkModeProvider).isDarkMode();

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              switchIcon(isDarkMode),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 1,
                  color: !isDarkMode ? AppColor.aluminium : AppColor.whisper,
                ),
              ),
              _itemWithIcon(
                isDarkMode,
                title: AppLocalizations.of(context)?.logout ?? '',
                icon: Icons.logout,
                isRedColor: true,
                onTap: () => _logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout() => showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              AppLocalizations.of(context)?.logout ?? '',
            ),
            content: Text(
              AppLocalizations.of(context)?.logout_confirm ?? '',
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  AppLocalizations.of(context)?.cancel ?? '',
                ),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () async {
                  await ref.read(loginStateNotifier.notifier).signOut();

                  showLoading(this.context);
                  Future.delayed(
                    const Duration(milliseconds: 300),
                    () {
                      Navigator.pop(this.context);
                      Navigator.pop(this.context);
                      Navigator.pop(this.context);
                    },
                  );
                },
                child: Text(
                  AppLocalizations.of(context)?.logout ?? '',
                ),
              ),
            ],
          );
        },
      );

  Widget _itemWithIcon(
    bool isDarkMode, {
    required String title,
    String? iconPath,
    required Function() onTap,
    IconData? icon,
    bool isRedColor = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode
                      ? AppColor.whisper
                      : isRedColor
                          ? AppColor.persianRed
                          : Colors.black,
                ),
              ),
              isNullOrEmpty(icon)
                  ? Image.asset(
                      iconPath ?? '',
                      height: 24,
                      width: 24,
                      color: isDarkMode
                          ? AppColor.whisper
                          : isRedColor
                              ? AppColor.persianRed
                              : Colors.black,
                    )
                  : Icon(
                      icon,
                      size: 24,
                      color: isDarkMode
                          ? AppColor.whisper
                          : isRedColor
                              ? AppColor.persianRed
                              : Colors.black,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget switchIcon(bool isDarkMode) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () async {
        ref.read(darkModeProvider.notifier).setDarkMode(!isDarkMode);
      },
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.dark_mode ?? '',
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlutterSwitch(
                width: 40.0,
                height: 20.0,
                toggleSize: 18.0,
                value: isDarkMode ? true : false,
                borderRadius: 10.0,
                padding: 1.0,
                activeColor: const Color(0xFF81c784),
                inactiveColor: AppColor.whisper,
                activeIcon: const Icon(
                  Icons.dark_mode,
                  size: 24,
                  color: AppColor.aluminium,
                ),
                inactiveIcon: const Icon(
                  Icons.light_mode,
                  size: 24,
                  color: AppColor.aluminium,
                ),
                onToggle: (value) {
                  ref.read(darkModeProvider.notifier).setDarkMode(!isDarkMode);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
