import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class GoBackButton extends StatelessWidget {
  Function()? defaultGoBack;
  final IconData? icon;
  final double? size;

  static Function()? goBackReplacer;

  Function()? onGoBack;

  Function()? goBack;

  final AlignmentGeometry? alignment;

  GoBackButton(
      {Key? key,
      this.defaultGoBack,
      this.icon,
      this.goBack,
      this.onGoBack,
      this.size,
      this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = size ?? 22;
    return IconButton(
      icon: Icon(
        icon ?? Icons.arrow_back,
        size: iconSize,color: Colors.white,
      ),
      iconSize: iconSize + 8,
      alignment: alignment ?? Alignment.center,
      color: Colors.black,
      onPressed: () async {
        if (onGoBack != null) {
          onGoBack!();
        }

        if (goBack != null) {
          goBack!();
          return;
        }

        if (goBackReplacer != null) {
          goBackReplacer!();
          return;
        }

        if (!await context.router.pop()) {
          if (defaultGoBack == null) {
            context.router.pushNamed("/");
            return;
          }
          defaultGoBack!();
          return;
        }
      },
    );
  }
}
