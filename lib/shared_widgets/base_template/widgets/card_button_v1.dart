import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni_credit/models/extensions/for_padding.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import '../../graphical_item/graphical_item.dart';
import '../../item_sizes.dart';

// Possible code improvements:
// Make body options configurable by a CardBodyType enum
// Separate this code in more than one file
// Consider reusing the classes specified here in other contexts, such as popup definition,
// not only it will allow you to strengthen your framework consistency, but it will also
// help in realizing possible issues with the current separation of concerns
// of each section of the button
// Make a separate static file for defining the DEFAULT values for the button

enum CardIntention { display, action }

class CardDimension {
  double? size;
  bool nulify;
  double? multiply;
  double? maxValue;
  ItemSize? itemSize;

  CardDimension(
      {this.size,
        this.multiply,
        this.maxValue,
        this.nulify = false,
        this.itemSize});

  getValue({double? defaultDefinedValue}) {
    if (nulify) {
      return null;
    }

    if (size == null) {
      return defaultDefinedValue == null
          ? defaultDefinedValue
          : defaultDefinedValue * (multiply ?? 1);
    }
    return min((size)! * (multiply ?? 1), maxValue ?? double.infinity);
  }

  static double defaultActionButtonHeight = 72;
}

class CardTextContent {
  final dynamic content;
  final Alignment? alignment;
  final TextStyle? textStyle;
  Color? color;
  final FontWeight? fontWeight;
  final double? size;
  final int? flex;

  final EdgeInsets? padding;

  CardTextContent({
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    this.content,
    this.alignment,
    this.textStyle,
    this.fontWeight,
    this.size,
    this.color,
    this.flex,
  });

  getStyle(CardButtonV1 cardButtonV1) {
    return textStyle ??
        TextStyle(
            color: color ??
                (cardButtonV1.backgroundColor == Colors.white
                    ? Colors.black
                    : Colors.white),
            fontSize: size ?? 14,
            fontWeight: fontWeight ?? FontWeight.w700);
  }

  Widget getContent(CardButtonV1 cardButtonV1) {
    Widget text = content is Widget
        ? content
        : Text(
      content,
      style: getStyle(cardButtonV1),
    );

    if (padding != null) {
      text = Padding(
        padding: padding!,
        child: text,
      );
    }

    if (alignment != null) {
      text = Align(
        alignment: alignment!,
        child: text,
      );
    }

    return text;
  }
}

class CardIconData {
  final dynamic icon;
  final Color? color;
  final double? size;
  final Function()? press;
  final bool useSpacing;
  final bool hide;
  final EdgeInsets? padding;
  final int? iconFlex;
  final Color? backgroundColor;

  CardIconData(
      {this.iconFlex,
        this.icon,
        this.padding,
        this.color,
        this.size,
        this.press,
        this.useSpacing = true,
        this.hide = false,
        this.backgroundColor,
        this.height});

  final double? height;

  double getIconSize(context, cardButtonV1) {
    return {
      ItemSize.large: 32.0,
      ItemSize.big: 32.0,
      ItemSize.small: 24.0
    }[cardButtonV1.buttonSize] ??
        16;
  }

  Color getIconColor() {
    return Colors.white;
  }

  getIcon(
      context,
      CardButtonV1, {
        icon,
        color,
        double? size,
      }) {
    size ??= getIconSize(context, CardButtonV1);
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

  Widget getContent(BuildContext context, CardButtonV1 cardButtonV1) {
    return hide
        ? Container()
        : Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GestureDetector(
          onTap: press,
          child: getIcon(context, cardButtonV1,
              icon: icon, color: color, size: size)),
    );
  }
}

/*
* class PressControl {
  bool? active;
  Function()? onPress;
  bool? pressEnabled;
* */

class CardButtonV1 extends StatelessWidget {
  final CardIntention? cardIntention;
  final bool usesInk;
  final bool usesNeumorphic;
  final bool? active;

  Function()? onPress;
  final bool? pressEnabled;
  void Function(PointerEnterEvent event)? onEnter;
  void Function(PointerExitEvent event)? onExit;
  int? flex;

  final double removeElevation = 0;

  final CardTextContent title;
  final CardTextContent? subtitle;

  final MainAxisSize rowMainAxis;

  final CardIconData? trailingIcon;
  final CardIconData? leadingIcon;

  Color? backgroundColor;
  Color? borderColor;
  final BorderSide? borderSide;
  final ShapeBorder? borderShape;
  final bool circleWrap;
  final MainAxisAlignment? rowMainAlignment;
  final String? tooltip;

  final Color? hoverColor;

  CardDimension? width;
  CardDimension? height;

  int flexMultiply;
  final ItemSize buttonSize;

  late CommonButtonUtility buttonUtility;
  final String? theme;

  final Color? stripColor;
  final EdgeInsets? sizePadding;

  CardButtonV1({
    super.key,
    required this.title,
    this.subtitle,
    this.cardIntention,
    this.usesInk = true,
    this.usesNeumorphic = false,
    this.active,
    this.leadingIcon,
    this.onPress,
    this.pressEnabled,
    this.onEnter,
    this.onExit,
    this.flexMultiply = 1,
    this.rowMainAlignment,
    this.width,
    this.height,
    this.buttonSize = ItemSize.normal,
    this.backgroundColor,
    this.tooltip,
    this.hoverColor,
    this.borderColor,
    this.borderSide,
    this.borderShape,
    this.rowMainAxis = MainAxisSize.max,
    this.circleWrap = false,
    this.stripColor,
    CommonButtonUtility? commonButtonUtility,
    this.theme,
    this.flex,
    this.trailingIcon,
    this.sizePadding,
  }) {
    buttonUtility = commonButtonUtility ?? const CommonButtonUtility();
    backgroundColor ??= ThemeColors.getSpecialColor();
  }

  Map<String, Map<String, dynamic>> buttonThemes = {};

  static double getDefaultBorderRadius() {
    return 10;
  }

  double getDefaultBorder() {
    return buttonSize == ItemSize.large ? 10.0 : 5.0;
  }

  String getTitleAsText() {
    return title.content.runtimeType == String ? title.content : "";
  }

  Function()? getOnPress() {
    return (pressEnabled ?? true) ? onPress : null;
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

    CardButtonV1SizeResolver sizeResolver =
    CardButtonV1SizeResolver(buttonSize);

    width ??= CardDimension();

    double? cardWidth = width!.getValue(
        defaultDefinedValue: sizeResolver.resolveWidth(context, widget: this));

    cardWidth ??= buttonUtility.width;

    double? cardHeight = height?.getValue(
        defaultDefinedValue:
        sizeResolver.resolveHeight(context, widget: this)) ??
        sizeResolver.resolveHeight(context, widget: this);

    // #todo: check if this is necessary?
    if (false) {
      double minWidth = buttonSize == ItemSize.smallish ? 100 : 160;
      cardWidth = (cardWidth == null) ? minWidth : max(cardWidth, minWidth);
    }

    if (buttonSize == ItemSize.unlimited) {
      cardWidth = null;
      // cardHeight = null;
    }

    if (buttonSize == ItemSize.minimal) {
      cardWidth = null;
    }

    if (theme != null && buttonThemes.containsKey(theme)) {
      Map<String, dynamic> buttonTheme = buttonThemes[theme]!;
      backgroundColor = buttonTheme['color'];
      borderColor = buttonTheme['border'];
      title.color = buttonTheme['text'];
    }

    if ((cardIntention == CardIntention.action && getOnPress() == null) ||
        (active != null && !active!)) {
      backgroundColor = ThemeColors.getDeactivatedColor();
    }

    /*  backgroundColor ??= getUserPrimaryColor();

    if (backgroundColor == getAppBackgroundColor() && title.color == null) {
      title.color = Colors.black;
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
            child: _ButtonBody(CardButtonV1: this)),
      ),
    );*/

    Widget button = _ButtonShape(
      cardButton: this,
      cardWidth: cardWidth,
    );

    return Padding(
      padding: sizePadding == null
          ? EdgeInsets.zero
          : sizePadding!.multiply(EdgeInsets.only(
          top: cardHeight ?? 0,
          bottom: cardHeight ?? 0,
          left: cardWidth ?? 0,
          right: cardWidth ?? 0)),
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: cardWidth ?? double.infinity),
          child:
          Container(width: cardWidth, height: cardHeight, child: button)),
    );
  }
}

class _ButtonShape extends StatelessWidget {
  final CardButtonV1 cardButton;
  final double? cardWidth;
  const _ButtonShape(
      {Key? key, required this.cardWidth, required this.cardButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = _ButtonBody(cardButtonV1: cardButton);
    if (cardWidth != null) {
      button = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: cardWidth!),
          child: Container(width: cardWidth, child: button));
    }
    BorderRadius cardRadius = BorderRadius.all(Radius.circular(
        cardButton.buttonUtility.border ?? cardButton.getDefaultBorder()));

    if (cardButton.usesInk) {
      button = InkWell(
          onTap: cardButton.getOnPress(),
          borderRadius: cardRadius,
          customBorder: cardButton.getShapeBorder(),
          hoverColor: cardButton
              .hoverColor /*??
              (cardButton.backgroundColor == getUserPrimaryColor()
                  ? getDarkPrimaryColor()
                  : null) */
          ,
          child: button);
    }

    if (cardButton.circleWrap) {
      button = CircleAvatar(
        backgroundColor: cardButton.backgroundColor,
        child: button,
      );
    } else {
      if (cardButton.usesNeumorphic && false) {
        /*button = NeumorphicButton(
          onPressed: () async {
            if (cardButton.onPress == null) {
              return;
            }
            await Future.delayed(Duration(milliseconds: 400));
            cardButton.onPress!();
          },
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
              color: cardButton.backgroundColor,
              //shadowDarkColor: cardButton.backgroundColor,
              // shadowLightColor: cardButton.backgroundColor,
              depth: 2),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: cardRadius,
                  border: cardButton.borderColor == null
                      ? null
                      : Border.all(color: cardButton.borderColor!)),
              child: button),
        );*/
      } else {
        button = Card(
          margin: EdgeInsets.zero,
          color: cardButton.backgroundColor,
          shape: cardButton.getShapeBorder(),
          child: button,
        );
      }
    }

    if (cardButton.tooltip != null && cardButton.tooltip != '') {
      button = Tooltip(
        message: cardButton.tooltip,
        child: button,
      );
    }

    if (!(cardButton.usesInk || cardButton.usesNeumorphic) &&
        cardButton.onPress != null) {
      button = GestureDetector(
        onTap: cardButton.onPress,
        child: button,
      );
    }

    if (cardButton.onPress != null ||
        cardButton.onEnter != null ||
        cardButton.onExit != null) {
      button = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: cardButton.onEnter,
        onExit: cardButton.onExit,
        child: button,
      );
    }

    return button;
  }
}

class _ButtonBody extends StatelessWidget {
  final CardButtonV1 cardButtonV1;
  const _ButtonBody({required this.cardButtonV1, Key? key}) : super(key: key);

  getElementFlex(int flex) {
    bool minButton = cardButtonV1.rowMainAxis == MainAxisSize.min;

    if (minButton) {
      return 0;
    }

    return cardButtonV1.flex ?? (flex * cardButtonV1.flexMultiply);
  }

  isIconButton() {
    return (cardButtonV1.title.content == null ||
        cardButtonV1.title.content == "") &&
        (cardButtonV1.subtitle == null ||
            cardButtonV1.subtitle!.content == "") &&
        cardButtonV1.leadingIcon != null;
  }

  getSpacer({useSpacer = true, color}) {
    bool minButton = cardButtonV1.rowMainAxis == MainAxisSize.min;

    if (minButton) {
      return Container();
    }

    if (!useSpacer) {
      return Container();
    }
    if (cardButtonV1.flex == 0) {
      return Container();
    }
    return Flexible(
        child: Container(
          color: color,
        ),
        flex: cardButtonV1.flex ?? 1);
  }

  getExpanded({Widget? child, flex, containerColor, height}) {
    if (child == null) {
      return Container();
    }
    if (flex == 0) {
      return child;
    }
    return Expanded(
      flex: cardButtonV1.flex ?? flex,
      child: Container(
        height: height,
        color: containerColor,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool minButton = cardButtonV1.rowMainAxis == MainAxisSize.min;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: cardButtonV1.width?.itemSize == ItemSize.minimal
          ? MainAxisSize.min
          : cardButtonV1.rowMainAxis,
      mainAxisAlignment: cardButtonV1.rowMainAlignment ??
          (cardButtonV1.buttonSize.isBigger(ItemSize.normal)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center),
      children: [
/*    */
        getSpacer(
            color: cardButtonV1.stripColor ??
                cardButtonV1.leadingIcon?.backgroundColor,
            useSpacer: cardButtonV1.leadingIcon?.useSpacing ??
                cardButtonV1.stripColor != null),

        getExpanded(
            height: cardButtonV1.leadingIcon?.height,
            flex: getElementFlex(cardButtonV1.leadingIcon == null
                ? 0
                : cardButtonV1.leadingIcon?.iconFlex ?? 2),
            child: cardButtonV1.leadingIcon?.getContent(context, cardButtonV1),
            containerColor: cardButtonV1.leadingIcon?.backgroundColor),

        getSpacer(useSpacer: cardButtonV1.leadingIcon?.useSpacing ?? false),
        isIconButton()
            ? Container()
            : getExpanded(
          flex: cardButtonV1.title.flex ?? getElementFlex(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            /*  crossAxisAlignment: minButton
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,*/
            children: [
              cardButtonV1.title.getContent(cardButtonV1),
              cardButtonV1.subtitle?.getContent(cardButtonV1) ??
                  Container(),
            ],
          ),
        ),

        getSpacer(useSpacer: cardButtonV1.trailingIcon?.useSpacing ?? false),

        isIconButton() || cardButtonV1.trailingIcon == null
            ? Container()
            : getExpanded(
            height: cardButtonV1.trailingIcon?.height,
            containerColor: cardButtonV1.trailingIcon?.backgroundColor,
            flex: getElementFlex(cardButtonV1.trailingIcon == null
                ? 0
                : cardButtonV1.trailingIcon!.iconFlex ?? 3),
            child: cardButtonV1.trailingIcon!
                .getContent(context, cardButtonV1))

        //Spacer(flex: spacer,),
      ],
    );
  }
}

class CommonButtonUtility {
  final double? width;
  final double? height;
  final double? border;
  const CommonButtonUtility({this.width, this.height, this.border});
}

class CardButtonV1SizeResolver extends ItemSizeResolver {
  CardButtonV1SizeResolver(super.itemSize);

  @override
  double? resolveHeight(context, {widget}) {
    ItemSize heightSize = (widget?.height?.itemSize) ?? itemSize;

    return {
      ItemSize.large: 110.0,
      ItemSize.big: 80.0,
      ItemSize.normal: 40.0,
      ItemSize.small: 40.0,
      ItemSize.smallish: 30.0,
      ItemSize.verySmall: 30.0,
    }[heightSize];
  }

  Map<ItemSize, double> widthResolver = {
    ItemSize.smallish: 0.08,
    ItemSize.small: 0.12,
    ItemSize.normal: 0.3,
    ItemSize.large: 0.8
  };

  Map<ItemSize, double> minWidthResolver = {
    ItemSize.small: 160,
  //  ItemSize.big: 400,

  };

  Map<ItemSize, double> rawResolver = {
    ItemSize.verySmall: 50,
    ItemSize.smallish: 100
  };

  @override
  double? resolveWidth(context, {widget}) {
    widget = widget as CardButtonV1?;

    ItemSize widthSize = (widget?.width?.itemSize) ?? itemSize;
    double widthMultiply = widthResolver[widthSize] ?? 0.4;

    if (widget != null) {
      if (rawResolver.containsKey(widthSize)) {
        return rawResolver[widthSize];
      }

      if (widthSize == ItemSize.smallish &&
          widget.getTitleAsText().length > 12 &&
          (widget.width == null || widget.width!.multiply == null)) {
        widthMultiply *= 1.3;
      }
    }

    double width = MediaQuery.of(context).size.width * (widthMultiply);

    if (minWidthResolver.containsKey(itemSize)) {
      width = max(width, minWidthResolver[itemSize]!);
    }

    return width;
  }
}
