import 'package:flutter/material.dart';

import '../widgets/message_dialog.dart';
import 'app_theme.dart';

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.aluminium),
        ),
      );
    },
  );
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<void> showCupertinoMessageDialog(
  BuildContext context,
  String? title,
  String? content, {
  Function()? onClose,
  String? buttonLabel,
  bool canClose = true,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: canClose,
    builder: (BuildContext context) {
      return MessageDialog(
        title: title,
        content: content,
        buttonLabel: buttonLabel,
        onClose: onClose,
      );
    },
  );
}
