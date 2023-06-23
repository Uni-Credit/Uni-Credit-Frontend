import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../responsive/media_queries.dart';
import '../base_template/widgets/card_button_v1.dart';
import '../item_sizes.dart';

class IconActionCardButton extends StatelessWidget {
  final String content;
  final Widget icon;
  final double? iconSize;
  final Function()? onPress;
  final bool? pressEnabled;
  final bool invertColors;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? contentColor;
  final bool forceMobile;
  final bool useIconInDesktop;
  final ItemSize? desktopSize;
  final ItemSize? mobileSize;

  final double numberOfIcons;

  const IconActionCardButton({
    Key? key,
    required this.content,
    required this.icon,
    this.numberOfIcons = 1,
    this.iconSize,
    this.desktopSize,
    this.mobileSize,
     this.onPress,
    this.pressEnabled,
    this.forceMobile = false,
    this.useIconInDesktop = false,
    this.invertColors = false,
    this.borderColor,
    this.contentColor,
    this.backgroundColor,
  }) : super(key: key);

  bool useMobile() {
    return isMobile() || forceMobile;
  }

  bool isUsingDesktopLeadingIcon() {
    return useIconInDesktop && !isMobile();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;

    ItemSize itemSize = desktopSize ?? ItemSize.small;
    dynamic widgetContent = useMobile() ? icon : content;

    if (useMobile()) {
      itemSize = mobileSize ?? ItemSize.verySmall;
    }

    double cardHeight = iconSize == null ? 40 : (iconSize! + 8);
    return CardButtonV1(
      tooltip: content,
      buttonSize: itemSize,
      cardIntention: CardIntention.action,
      height: CardDimension(size: cardHeight),
      borderColor: borderColor,
      width: CardDimension(multiply: numberOfIcons),
      backgroundColor: getBackgroundColor(),
      title: CardTextContent(
        content: widgetContent,
        color: getTextColor(),
      ),
      leadingIcon: isUsingDesktopLeadingIcon()
          ? CardIconData(
              padding: EdgeInsets.only(left: 6), icon: icon, useSpacing: true)
          : null,
      trailingIcon:
          isUsingDesktopLeadingIcon() ? CardIconData(useSpacing: true) : null,
      onPress: onPress,
      pressEnabled: pressEnabled,
    );
  }

  getTextColor() {
    contentColor
        //  ?? (invertColors ? getUserPrimaryColor() : getIceWhite())
        ;
  }

  getBackgroundColor() {
    backgroundColor
        // ?? (invertColors ? getIceWhite() : getUserPrimaryColor())
        ;
  }
}
