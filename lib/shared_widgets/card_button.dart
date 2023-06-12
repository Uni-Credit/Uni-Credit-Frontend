import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'graphical_item/graphical_item.dart';
import 'item_sizes.dart';

enum CardIntention { display, action }

class CardButton extends StatelessWidget {
  final CardIntention? cardIntention;
  final bool usesInk;
  final bool? active;

  Function()? onPress;
  final bool pressEnabled;
  void Function(PointerEnterEvent event)? onEnter;
  void Function(PointerExitEvent event)? onExit;
  int? flex;

  final double removeElevation = 0;

  final dynamic title;
  final Alignment? titleAlignment;
  final TextStyle? titleStyle;
  Color? titleColor;
  final FontWeight? titleWeight;
  final double? titleSize;
  final int? titleFlex;
  final EdgeInsets? titlePadding;

  final dynamic subTitle;
  final TextStyle? subtitleStyle;
  Color? subtitleColor;

  final Function()? trailingPress;
  final dynamic trailingIcon;
  double? trailingIconSize;
  final int? trailingFlex;
  final Color? trailingColor;
  final Alignment? trailingAlignment;
  final EdgeInsets? trailingPadding;
  final bool useTrailingSpacing;

  final MainAxisAlignment? mainAxisAlignment;

  final dynamic leadingIcon;
  final Color? leadingIconColor;
  final double? leadingIconSize;
  final Function()? leadingIconPress;
  final bool useLeadingSpacing;
  final EdgeInsets? leadingIconPadding;
  final int? leadingIconFlex;
  final Alignment? leadingAlignment;

  Color? backgroundColor;
  Color? borderColor;
  final BorderSide? borderSide;
  final ShapeBorder? borderShape;
  final bool circleWrap;

  final Color? hoverColor;

  double? cardWidth;
  bool nulifyWidth;
  double? widthMultiply;
  double? maxWidth;

  double? heightMultiply;
  bool nulifyHeight;
  double? cardHeight;
  double? maxHeight;

  int flexMultiply;
  final ItemSize buttonSize;

  late CommonButtonUtility buttonUtility;
  final String? theme;

  CardButton({
    super.key,
    required this.title,
    this.titleFlex,
    this.titleColor,
    this.titleStyle,
    this.titlePadding,
    this.titleAlignment,
    this.titleSize,
    this.subTitle,
    this.subtitleStyle,
    this.subtitleColor,
    this.cardIntention,
    this.usesInk = true,
    this.active,
    this.leadingIcon,
    this.leadingAlignment,
    this.leadingIconColor,
    this.leadingIconSize,
    this.leadingIconPress,
    this.leadingIconPadding,
    this.useLeadingSpacing = true,
    this.onPress,
    this.pressEnabled = true,
    this.onEnter,
    this.onExit,
    this.cardWidth,
    this.maxWidth,
    this.nulifyWidth = false,
    this.widthMultiply,
    this.flexMultiply = 1,
    this.cardHeight,
    this.maxHeight,
    this.nulifyHeight = false,
    this.heightMultiply,
    this.buttonSize = ItemSize.large,
    this.backgroundColor,
    this.hoverColor,
    this.borderColor,
    this.borderSide,
    this.borderShape,
    this.circleWrap = false,
    this.trailingIcon,
    this.trailingPress,
    this.trailingAlignment,
    this.trailingPadding,
    this.trailingIconSize,
    this.trailingFlex,
    CommonButtonUtility? commonButtonUtility,
    this.theme,
    this.flex,
    this.titleWeight,
    this.mainAxisAlignment,
    this.trailingColor,
    this.leadingIconFlex,
    this.useTrailingSpacing = true,
  }) {
    buttonUtility = commonButtonUtility ?? const CommonButtonUtility();
  }

  Map<String, Map<String, dynamic>> buttonThemes = {};

  static double getDefaultBorderRadius() {
    return 10;
  }

  getDefaultBorder() {
    return buttonSize == ItemSize.large ? 10 : 5;
  }

  String getTitleAsText() {
    return title.runtimeType == String ? title : "";
  }

  Function()? getOnPress() {
    return pressEnabled ? onPress : null;
  }

  getShapeBorder() {
    BorderRadius cardRadius = BorderRadius.all(
        Radius.circular(buttonUtility.border ?? getDefaultBorder()));

    return borderShape ??
        RoundedRectangleBorder(
            side: borderSide ??
                BorderSide(color: borderColor ?? backgroundColor!),
            borderRadius: cardRadius);
  }

  @override
  Widget build(BuildContext context) {
    if (buttonSize == ItemSize.minimal) {
      flex = 0;
    }

    double? width = cardWidth;
    width ??= buttonUtility.width;

    CardButtonSizeResolver sizeResolver = CardButtonSizeResolver(buttonSize);

    width ??= sizeResolver.resolveWidth(context, widget: this);
    cardHeight ??= sizeResolver.resolveHeight(context, widget: this);

    double minWidth = buttonSize == ItemSize.smallish ? 100 : 160;
    width = width == null ? minWidth : max(width!, minWidth);

    /*if(screenModel != "desktop") {
      cardWidth = MediaQuery.of(context).size.width*75/100;
    }*/

    if (widthMultiply != null) {
      width = width * widthMultiply!;
      if (width < 0) {
        width = null;
      }
    }

    if (heightMultiply != null) {
      cardHeight = cardHeight! * heightMultiply!;
    }

    if (buttonSize == ItemSize.unlimited) {
      cardWidth = null;
      cardHeight = null;
    }

    if (nulifyWidth) {
      width = null;
    }

    if (nulifyHeight) {
      cardHeight = null;
    }

    if (buttonSize == ItemSize.minimal) {
      cardWidth = null;
    }

    BorderRadius cardRadius = BorderRadius.all(
        Radius.circular(buttonUtility.border ?? getDefaultBorder()));

    if (theme != null && buttonThemes.containsKey(theme)) {
      Map<String, dynamic> buttonTheme = buttonThemes[theme]!;
      backgroundColor = buttonTheme['color'];
      borderColor = buttonTheme['border'];
      titleColor = buttonTheme['text'];
    }

    if ((cardIntention == CardIntention.action && getOnPress() == null) ||
        (active != null && !active!)) {
      backgroundColor = Color(0xffcccccc);
    }

    backgroundColor ??= Colors.blueAccent; //getUserPrimaryColor();
    /*getAppBackgroundColor()
    if (backgroundColor ==  && titleColor == null) {
      titleColor = Colors.black;
    }*/

    /* Widget button = InkWell(
      onTap: getOnPress(),
      borderRadius: cardRadius,
      customBorder: getShapeBorder(),
      hoverColor: hoverColor ??
          (backgroundColor == getUserPrimaryColor()
              ? getDarkPrimaryColor()
              : null),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: _ButtonBody(cardButton: this)),
      ),
    );*/

    Widget button = _ButtonBody(cardButton: this);

    button = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width ?? double.infinity),
      child: SizedBox(width: width, height: cardHeight, child: button),
    );
    if (usesInk) {
      button = InkWell(
          onTap: getOnPress(),
          borderRadius: cardRadius,
          customBorder: getShapeBorder(),
          hoverColor: hoverColor ?? Colors.white60,
          /*??
              (backgroundColor == getUserPrimaryColor()
                  ? getDarkPrimaryColor()
                  : null),*/
          child: button);

      if (circleWrap) {
        button = CircleAvatar(
          backgroundColor: backgroundColor,
          child: button,
        );
      } else {
        button = Card(
          margin: EdgeInsets.zero,
          color: backgroundColor,
          shape: getShapeBorder(),
          child: button,
        );
      }
    } else {
      button = Container(
        color: backgroundColor,
        child: button,
      );
    }

    if (onPress != null || onEnter != null || onExit != null) {
      button = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: onEnter,
        onExit: onExit,
        child: button,
      );
    }

    if (!usesInk && onPress != null) {
      button = GestureDetector(
        onTap: onPress,
        child: button,
      );
    }

    button = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width ?? double.infinity),
      child: button,
    );

    return button;
  }
}

class _ButtonBody extends StatelessWidget {
  final CardButton cardButton;
  const _ButtonBody({required this.cardButton, Key? key}) : super(key: key);

  double getTitleFontSize(context) {
    return cardButton.titleSize ??
        (cardButton.buttonSize == ItemSize.large
            ? max(min(24, MediaQuery.of(context).size.width * 0.02), 18)
            : 16);
  }

  getSubtitleFontSize(context) {
    return 14;
  }

  getTitleAlignment() {
    return cardButton.titleAlignment ??
        (cardButton.cardIntention != null
            ? cardButton.cardIntention == CardIntention.action
                ? Alignment.center
                : Alignment.topLeft
            : (cardButton.buttonSize == ItemSize.large
                ? Alignment.topLeft
                : Alignment.center));
  }

  getTitleColor() {
    return cardButton.titleColor ??
        (cardButton.backgroundColor == Colors.white
            ? Colors.black
            : Colors.white);
  }

  double getIconSize(context) {
    return {
          ItemSize.large: 32.0,
          ItemSize.big: 32.0,
          ItemSize.small: 24.0
        }[cardButton.buttonSize] ??
        16;
  }

  Color getIconColor() {
    return Colors.white;
  }

  getElementFlex(int flex) {
    return cardButton.flex ?? (flex * cardButton.flexMultiply);
  }

  isIconButton() {
    return (cardButton.title == null || cardButton.title == "") &&
        (cardButton.subTitle == null || cardButton.subTitle == "") &&
        cardButton.leadingIcon != null;
  }

  getIcon(
    context, {
    icon,
    color,
    double? size,
  }) {
    size ??= getIconSize(context);
    if (icon is GraphicalItem) {
      switch (icon.type) {
        case Graphical.icon:
          icon = icon.item;
          break;
        case Graphical.svg:
          return SvgPicture.asset(
            icon.item,
            width: size,
          );
        case Graphical.image:
          return Image.asset(icon.item);
      }
    }

    return icon is IconData
        ? Icon(
            icon,
            size: size,
            color: color ?? getIconColor(),
          )
        : icon;
  }

  getSpacer({useSpacer = true}) {
    if (!useSpacer) {
      return Container();
    }
    if (cardButton.flex == 0) {
      return Container();
    }
    return Spacer(flex: cardButton.flex ?? 1);
  }

  getExpanded({child, flex}) {
    if (cardButton.flex == 0) {
      return Container();
    }
    return Expanded(
      child: child,
      flex: cardButton.flex ?? flex,
    );
  }

  @override
  Widget build(BuildContext context) {
    int spacer = cardButton.flex ?? 1;

    bool hideLeadingIcon = (cardButton.titleAlignment != null &&
            cardButton.titleAlignment!.x == Alignment.centerLeft.x &&
            cardButton.leadingIcon == null) ||
        cardButton.leadingIconFlex == 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          cardButton.mainAxisAlignment ?? MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        getSpacer(useSpacer: cardButton.useLeadingSpacing),
        hideLeadingIcon
            ? Container()
            : getExpanded(
                flex: getElementFlex(cardButton.leadingIconFlex ?? 2),
                child: Align(
                  alignment:
                      cardButton.leadingAlignment ?? Alignment.centerLeft,
                  child: Padding(
                    padding: cardButton.leadingIconPadding ?? EdgeInsets.zero,
                    child: GestureDetector(
                        onTap: cardButton.leadingIconPress,
                        child: getIcon(context,
                            icon: cardButton.leadingIcon,
                            color: cardButton.leadingIconColor,
                            size: cardButton.leadingIconSize)),
                  ),
                ),
              ),

        getSpacer(useSpacer: cardButton.useLeadingSpacing),

        isIconButton()
            ? Container()
            : getExpanded(
                flex: cardButton.titleFlex ?? getElementFlex(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: cardButton.titlePadding ?? EdgeInsets.zero,
                      child: Align(
                        alignment: getTitleAlignment(),
                        child: cardButton.title is Widget
                            ? cardButton.title
                            : Text(
                                cardButton.title,
                                style: cardButton.titleStyle ??
                                    TextStyle(
                                        color: getTitleColor(),
                                        fontSize: getTitleFontSize(context),
                                        fontWeight: cardButton.titleWeight ??
                                            FontWeight.w700),
                              ),
                      ),
                    ),
                    cardButton.subTitle != null
                        ? (cardButton.subTitle is Widget
                            ? cardButton.subTitle
                            : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  cardButton.subTitle!,
                                  style: cardButton.subtitleStyle ??
                                      TextStyle(
                                        color: cardButton.subtitleColor ??
                                            Colors.white,
                                        fontSize: getSubtitleFontSize(context),
                                      ),
                                ),
                              ))
                        : Container(),
                  ],
                ),
              ),

        getSpacer(useSpacer: !isIconButton()),

        isIconButton()
            ? Container()
            : _CardTrailingIcon(
                buttonBody: this,
              ),

        //Spacer(flex: spacer,),
      ],
    );
  }
}

class _CardTrailingIcon extends StatelessWidget {
  final _ButtonBody buttonBody;
  late CardButton cardButton;

  _CardTrailingIcon({required this.buttonBody, Key? key}) : super(key: key) {
    cardButton = buttonBody.cardButton;
  }

  @override
  Widget build(BuildContext context) {
    bool isPressable = (cardButton.trailingPress != null ||
        buttonBody.cardButton.getOnPress() != null);

    Widget trailingWidget = buttonBody.getIcon(context,
            icon: cardButton.trailingIcon ??
                (cardButton.buttonSize == ItemSize.large
                    ? Icons.arrow_forward_ios_rounded
                    : null),
            size: cardButton.trailingIconSize,
            color: cardButton.trailingColor) ??
        Container();
    /*cardButton.trailingIcon is Widget
        ? cardButton.trailingIcon
        : Icon(
      cardButton.trailingIcon ??
          (cardButton.buttonSize == ItemSize.large
              ? Icons.arrow_forward_ios_rounded
              : null),
      size: cardButton.trailingIconSize ??
          buttonBody.getIconSize(context),
      color: buttonBody.getIconColor(),
    );*/

    if (isPressable) {
      trailingWidget = MouseRegion(
        cursor:
            isPressable ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: GestureDetector(
            onTap: cardButton.trailingPress, child: trailingWidget),
      );
    }

    return Expanded(
        flex: buttonBody.getElementFlex(cardButton.trailingFlex ?? 3),
        child: Padding(
          padding: cardButton.trailingPadding ?? EdgeInsets.zero,
          child: Align(
              alignment: cardButton.trailingAlignment ?? Alignment.center,
              child: trailingWidget),
        ));
  }
}

class CommonButtonUtility {
  final double? width;
  final double? height;
  final double? border;
  const CommonButtonUtility({this.width, this.height, this.border});
}

class CardButtonSizeResolver extends ItemSizeResolver {
  CardButtonSizeResolver(super.itemSize);

  @override
  double? resolveHeight(context, {widget}) {
    return {
      ItemSize.large: 110.0,
      ItemSize.big: 80.0,
      ItemSize.small: 40.0,
      ItemSize.normal: 40.0,
      ItemSize.smallish: 30.0,
      ItemSize.verySmall: 25.0
    }[itemSize];
  }

  @override
  resolveWidth(context, {widget}) {
    if (itemSize == ItemSize.verySmall) {
      return 50;
    }
    widget = widget as CardButton?;

    Map<ItemSize, double> widthResolver = {
      ItemSize.smallish: 0.08,
      ItemSize.small: 0.12,
      ItemSize.normal: 0.3
    };

    double widthMultiply = widthResolver[itemSize] ?? 0.4;

    if (widget != null) {
      if (itemSize == ItemSize.smallish &&
          widget.getTitleAsText().length > 12 &&
          widget.widthMultiply == null) {
        widthMultiply *= 1.3;
      }
    }

    return MediaQuery.of(context).size.width * (widthMultiply);
  }
}
