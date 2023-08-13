import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:note_app/screens/sign_up/sign_up_notifier.dart';
import 'package:note_app/screens/sign_up/sign_up_state.dart';

import '../../routes.dart';
import '../../util/screen_util.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_input_field.dart';

class SignUpScreen extends StatefulHookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showCofPassword = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    ref.listen<SignUpState>(signUpStateNotifier, (previous, state) {
      if (state is SignUpStateFailure) {
        log('error SignUp: ${state.error}');
        if (state.error == 'email-already-in-use') {
          showCupertinoMessageDialog(
            context,
            AppLocalizations.of(context)?.error,
            AppLocalizations.of(context)?.email_used,
          );
        } else {
          showCupertinoMessageDialog(
            context,
            AppLocalizations.of(context)?.error,
            state.error,
          );
        }
      }
      if (state is SignUpStateLoading) {
        showLoading(context);
        Future.delayed(
          const Duration(milliseconds: 300),
          () => Navigator.pop(context),
        );
      }
      if (state is SignUpStateSuccess) {
        showCupertinoMessageDialog(
          context,
          AppLocalizations.of(context)?.signUp_success,
          AppLocalizations.of(context)?.go_to_login,
          buttonLabel: AppLocalizations.of(context)?.login,
          onClose: () => Navigator.pushNamed(context, AppRoute.login),
        );
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _form(width),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.already_account ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, AppRoute.login),
                          child: Text(
                            AppLocalizations.of(context)?.login ?? '',
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
    );
  }

  Widget _form(double width) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 16),
            child: Text(
              AppLocalizations.of(context)?.create_account ?? '',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 16),
            child: InputFieldCustom(
              controller: _nameController,
              labelText: 'Name',
              prefixIcon: Icons.person_outline,
              noWhiteList: true,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter name';
              //   }
              //   return null;
              // },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: InputFieldCustom(
              controller: _emailController,
              // initText: 'test@gmail.com',
              labelText: AppLocalizations.of(context)?.email_username,
              // hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)?.enter_username;
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
              labelText: AppLocalizations.of(context)?.password,
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
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: InputFieldCustom(
              controller: _confPasswordController,
              labelText: AppLocalizations.of(context)?.confirm_password,
              prefixIcon: Icons.lock_outline,
              showSuffix: true,
              suffix1: Icons.remove_red_eye_outlined,
              suffix2: Icons.visibility_off_outlined,
              isShow: _showCofPassword,
              onTapSuffix: () =>
                  setState(() => _showCofPassword = !_showCofPassword),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)?.enter_password;
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)?.password_least_8_char;
                } else if (_passwordController.text !=
                    _confPasswordController.text) {
                  return AppLocalizations.of(context)?.math_password;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Container(
              alignment: Alignment.center,
              child: PrimaryButton(
                width: width,
                text: AppLocalizations.of(context)?.signup,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    ref.read(signUpStateNotifier.notifier).signUp(
                          email: _emailController.text,
                          password: _passwordController.text,
                          name: _nameController.text,
                        );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
