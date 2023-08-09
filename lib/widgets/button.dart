import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../network/provider/dark_mode_provider.dart';
import '../util/app_theme.dart';
import '../util/util.dart';

class PrimaryButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider).isDarkMode();

    return ButtonTheme(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor:
              isDarkMode ? AppColor.aluminium : AppColor.greyChateau,
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
                    color: isDarkMode ? AppColor.whisper : AppColor.midGrey,
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
                    color: isDarkMode ? AppColor.whisper : AppColor.midGrey,
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
