import 'dart:math';
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final void Function() onPressed;
  final String display;

  final Color? color;
  TextStyle? textStyle;
  MainAxisAlignment? mainAlignment;
  double? topPadding;

  HighlightedText(
      {required this.onPressed,
      required this.display,
      this.textStyle,
      this.topPadding,
      Key? key,
      this.mainAlignment,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    textStyle ??= TextStyle(
      fontSize: 18,
    );

    textStyle = textStyle!.copyWith(color: color ?? getTextColor());

    return Padding(
      padding: EdgeInsets.only(
          top: topPadding ?? min(MediaQuery.of(context).size.height * 0.1, 40)),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: mainAlignment ?? MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              display,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }

  static getTextColor() {
    return Colors.blueAccent;
  }
}
