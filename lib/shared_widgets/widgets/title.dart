import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../shared_widgets/graphical_item/graphical_item.dart';
import '../../../shared_widgets/responsive/media_queries.dart';

enum TextType { subtitle, title }

class TitleWidget extends StatelessWidget {
  final String title;
  final dynamic icon;

  final FontWeight? titleWeight;
  final double? titleSize;

  final TextType textType;
  final double? paddingBottom;
  final MainAxisAlignment? alignment;

  final TextStyle? tittleStyle;

  final MainAxisSize? mainAxisSize;

  static Color textColor = Colors.black;


  final Color? textColorForTitle;
  const TitleWidget(
      {Key? key,
      required this.title,
      this.mainAxisSize = MainAxisSize.min,
      this.icon,
      this.tittleStyle,
      this.alignment,
      this.paddingBottom,
      this.titleWeight,
      this.titleSize,
        this.textColorForTitle,
      this.textType = TextType.title})
      : super(key: key);

  getTextSize(context) {
    double screenFontSize = MediaQuery.of(context).size.width * 0.35;
    double fontSize = titleSize ?? (textType == TextType.title ? 30 : 16);

    double smallestFontSize = fontSize * 0.5;

    fontSize = min(fontSize, screenFontSize);

    fontSize = max(fontSize, smallestFontSize);

    if (isMobile()) {
      fontSize *= 0.8;
    }

    return fontSize;
  }

  getFontWeight() {
    return titleWeight ??
        (tittleStyle != null
            ? tittleStyle!.fontWeight
            : (textType == TextType.title ? FontWeight.w700 : null));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: paddingBottom ?? MediaQuery.of(context).size.height * 0.025),
      child: Row(
        mainAxisAlignment: alignment ?? MainAxisAlignment.start,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        children: <Widget>[
          icon == null
              ? Container()
              : icon is IconData
                  ? Icon(
                      icon,
                      size: 24,
                      color: Colors.black45,
                    )
                  : renderIcon(icon),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: icon == null ? 0 : 10),
              child: AutoSizeText(
                title,

                maxLines: 2,
                //overflowReplacement: AutoSizeText(title, maxLines: 3, presetFontSizes: [smallestFontSize],),
                style: tittleStyle != null
                    ? tittleStyle!.copyWith(fontSize: getTextSize(context))
                    : TextStyle(
                        fontSize: getTextSize(context),
                        color: textColorForTitle ?? textColor,
                        fontWeight: getFontWeight()),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}

/*
class TitleConfigurations  extends Cubit<TextStyle> {
  TitleConfigurations(super.initialState);

}*/
