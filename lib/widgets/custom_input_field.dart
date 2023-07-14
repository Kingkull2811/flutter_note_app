import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kull_note_app/network/provider/dark_mode_provider.dart';

import '../util/app_theme.dart';
import '../util/util.dart';

class InputFieldCustom extends ConsumerWidget {
  // final BuildContext context;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final String? initText;
  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool showSuffix;
  final bool isShow;
  final IconData? suffix1;
  final IconData? suffix2;
  final Function()? onTap;
  final Function()? onTapSuffix;
  final bool readOnly;
  final String? iconPath;
  final int? maxText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextAlign? textAlign;
  final Pattern? whiteList;

  const InputFieldCustom({
    super.key,
    // required this.context,
    this.controller,
    this.inputAction,
    this.initText,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.showSuffix = false,
    this.isShow = true,
    this.onTap,
    this.onTapSuffix,
    this.readOnly = false,
    this.iconPath,
    this.maxText,
    this.keyboardType,
    this.validator,
    this.textAlign,
    this.suffix1,
    this.suffix2,
    this.whiteList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initText != null) {
      controller?.text = initText!;
    }

    final isDarkMode = !ref.watch(darkModeProvider).isDarkMode();

    return readOnly
        ? Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isDarkMode ? AppColor.whisper : AppColor.aluminium,
            ),
            child: ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              horizontalTitleGap: 4,
              leading: isNotNullOrEmpty(prefixIcon)
                  ? Icon(
                      prefixIcon,
                      size: 24,
                      color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                    )
                  : isNotNullOrEmpty(iconPath)
                      ? Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Image.asset(
                            '$iconPath',
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                            color: isDarkMode
                                ? AppColor.midGrey
                                : AppColor.whisper,
                          ),
                        )
                      : null,
              // contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
              title: Text(
                labelText ?? hintText ?? '',
                style: TextStyle(
                  color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                ),
              ),
            ),
          )
        : TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            controller: controller,
            validator: validator,
            obscureText: !isShow,
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxText),
              FilteringTextInputFormatter.allow(whiteList ?? RegExp('([\\S])')),
            ],
            textAlign: textAlign ?? TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: inputAction ?? TextInputAction.done,
            onFieldSubmitted: (value) {},
            onChanged: (_) {},
            keyboardType: keyboardType ?? TextInputType.text,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
            ),
            decoration: InputDecoration(
                prefixIcon: isNotNullOrEmpty(prefixIcon)
                    ? Icon(
                        prefixIcon,
                        size: 24,
                        color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                      )
                    : isNotNullOrEmpty(iconPath)
                        ? Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Image.asset(
                              '$iconPath',
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                              color: isDarkMode
                                  ? AppColor.midGrey
                                  : AppColor.whisper,
                            ),
                          )
                        : null,
                prefixIconColor:
                    isDarkMode ? AppColor.whisper : AppColor.midGrey,
                suffixIcon: showSuffix
                    ? InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: onTapSuffix,
                        child: Icon(
                          isShow ? suffix1 : suffix2,
                          size: 24,
                          color:
                              isDarkMode ? AppColor.midGrey : AppColor.whisper,
                        ),
                      )
                    : null,
                suffixIconColor:
                    isDarkMode ? AppColor.midGrey : AppColor.whisper,
                contentPadding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
                filled: true,
                fillColor: isDarkMode ? AppColor.whisper : AppColor.aluminium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1,
                    color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1,
                    color: isDarkMode ? AppColor.whisper : AppColor.midGrey,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1,
                    color: isDarkMode ? AppColor.whisper : AppColor.midGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1,
                    color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.redAccent),
                ),
                labelText: labelText,
                labelStyle: TextStyle(
                  color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: isDarkMode ? AppColor.midGrey : AppColor.whisper,
                )),
          );
  }
}
