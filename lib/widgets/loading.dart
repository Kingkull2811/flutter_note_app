import 'package:flutter/material.dart';

import '../util/app_theme.dart';

class AnimationLoading extends StatelessWidget {
  const AnimationLoading({
    Key? key,
    this.size,
    this.strokeWidth,
    this.useMaterialWidget = false,
  }) : super(key: key);
  final double? size;
  final double? strokeWidth;
  final bool useMaterialWidget;

  @override
  Widget build(BuildContext context) {
    return useMaterialWidget
        ? Material(
            color: Colors.white,
            child: Center(
              child: SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: strokeWidth ?? 2,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColor.aluminium),
                ),
              ),
            ),
          )
        : Center(
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth ?? 2,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColor.aluminium),
              ),
            ),
          );
  }
}
