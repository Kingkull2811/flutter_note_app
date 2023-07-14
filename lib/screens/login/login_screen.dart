import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kull_note_app/network/provider/auth_provider.dart';
import 'package:kull_note_app/screens/login/login_state_notifier.dart';

import '../../main.dart';
import '../../routes.dart';
import '../../util/app_theme.dart';
import '../../util/screen_util.dart';
import '../../util/shared_preferences_storage.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_input_field.dart';
import 'login_state.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    ref.listen<LoginState>(loginStateNotifier, (previous, state) {
      if (state is LoginStateFailure) {
        if (state.error == 'user-not-found') {
          showCupertinoMessageDialog(
            context,
            AppLocalizations.of(context)?.error,
            AppLocalizations.of(context)?.user_not_found,
          );
        } else if (state.error == 'wrong-password') {
          showCupertinoMessageDialog(
            context,
            AppLocalizations.of(context)?.error,
            AppLocalizations.of(context)?.wrong_pass,
          );
        } else {
          showCupertinoMessageDialog(
            context,
            AppLocalizations.of(context)?.error,
            state.error,
          );
        }
      }
      if (state is LoginStateLoading) {
        showLoading(context);
        Future.delayed(
          const Duration(milliseconds: 300),
          () => Navigator.pop(context),
        );
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _form(width),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)?.not_have_account ??
                                '',
                            style: const TextStyle(fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoute.signup),
                            child: Text(
                              AppLocalizations.of(context)?.signup ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(double width) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: const Text('Skip login'),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    MyApp.themeNotifier.value =
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                    await SharedPreferencesStorage().setNightMode(
                      MyApp.themeNotifier.value == ThemeMode.light
                          ? false
                          : true,
                    );
                  },
                  child: Icon(
                    MyApp.themeNotifier.value == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 24,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? AppColor.aluminium
                        : AppColor.linkWater,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 60, 0, 16),
            child: Text(
              AppLocalizations.of(context)?.welcome_back_content ?? '',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 48, 0, 16),
            child: InputFieldCustom(
              controller: _emailController,
              initText: 'test@gmail.com',
              labelText: AppLocalizations.of(context)?.email_username,
              // hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)?.enter_username;
                  // } else if (!emailRegex.hasMatch(value)) {
                  //   return AppLocalizations.of(context)?.invalid_email;
                } else if (value.length < 5) {
                  return AppLocalizations.of(context)?.email_5_char;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: InputFieldCustom(
              controller: _passwordController,
              initText: '12345678',
              labelText: AppLocalizations.of(context)?.password,
              // hintText: 'Enter your password',
              prefixIcon: Icons.lock_outline,
              showSuffix: true,
              suffix1: Icons.remove_red_eye_outlined,
              suffix2: Icons.visibility_off_outlined,
              isShow: _showPassword,
              onTapSuffix: () => setState(() => _showPassword = !_showPassword),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)?.enter_password;
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)?.password_least_8_char;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  //todo: forgot password
                },
                child: Text(
                  AppLocalizations.of(context)?.forgot_password ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Container(
              alignment: Alignment.center,
              child: PrimaryButton(
                width: width,
                text: AppLocalizations.of(context)?.login,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    //login action
                    ref.read(loginStateNotifier.notifier).login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)?.or ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: 70,
                      iconPath: 'images/ic_apple.png',
                      onTap: () {
                        if (defaultTargetPlatform == TargetPlatform.android) {
                          showCupertinoMessageDialog(
                            context,
                            'Error login!',
                            'Sorry, This feature is only available on ios devices.',
                          );
                        } else {
                          ref.watch(authRepositoryProvider).signInWithApple();
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: 70,
                      iconPath: 'images/ic_google.png',
                      onTap: () {
                        ref.watch(authRepositoryProvider).signInWithGoogle();
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      width: 70,
                      iconPath: 'images/ic_facebook.png',
                      onTap: () {
                        if (defaultTargetPlatform == TargetPlatform.android) {
                          showCupertinoMessageDialog(
                            context,
                            'Error with Facebook login!',
                            'Sorry, there is some error with the Facebook login in android devices, we will fix it soon.',
                          );
                        } else {
                          ref
                              .watch(authRepositoryProvider)
                              .signInWithFacebook();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
