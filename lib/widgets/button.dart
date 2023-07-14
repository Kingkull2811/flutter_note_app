import 'package:flutter/material.dart';

import '../main.dart';
import '../util/app_theme.dart';
import '../util/util.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final IconData? suffixIcon;
  final String? iconPath;
  final double width;

  ///for disable button
  final bool isDisable;

  const PrimaryButton({
    Key? key,
    required this.width,
    this.text,
    this.onTap,
    this.isDisable = false,
    this.suffixIcon,
    this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: MyApp.themeNotifier.value == ThemeMode.light
              ? AppColor.aluminium
              : AppColor.greyChateau,
          foregroundColor: AppColor.linkWater,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: AppColor.aluminium),
          ),
        ),
        child: Container(
          width: width,
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNotNullOrEmpty(suffixIcon))
                Padding(
                  padding: EdgeInsets.only(
                    right: isNotNullOrEmpty(text) ? 16 : 0,
                  ),
                  child: Icon(
                    suffixIcon,
                    size: 24,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? AppColor.whisper
                        : AppColor.midGrey,
                  ),
                ),
              if (isNotNullOrEmpty(iconPath))
                Padding(
                  padding: EdgeInsets.only(
                    right: isNotNullOrEmpty(text) ? 16 : 0,
                  ),
                  child: Image.asset(
                    iconPath ?? '',
                    height: 24,
                    width: 24,
                    // color: isDisable ? AppColor.aluminium : Colors.white,
                  ),
                ),
              if (isNotNullOrEmpty(text))
                Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 22,
                    color: MyApp.themeNotifier.value == ThemeMode.light
                        ? AppColor.whisper
                        : AppColor.midGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
