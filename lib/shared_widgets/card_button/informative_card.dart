import 'package:framework/models/extensions/basic_types/for_string.dart';
import 'package:flutter/material.dart';
import '../card_button.dart';
import '../item_sizes.dart';

// "well defined design" card configuration (what if we have a .copyWith() function in card button?)
class InformativeCard extends StatelessWidget {
  final String title;
  final dynamic subtitle;
  final dynamic leading;
  final dynamic trailing;
  final Function()? trailingPress;
  final int? trailingFlex;

  final int? titleFlex;
  final double? titleSize;
  final Alignment? titleAlignment;
  final int? leadingFlex;
  final Color? leadingColor;
  final Function()? onPress;
  final EdgeInsets? titlePadding;

  final double multiplyHeight;
  final Color? borderColor;

  const InformativeCard(
      {Key? key,
      required this.title,
      this.titleFlex,
      this.multiplyHeight = 1,
      this.titleAlignment,
      this.subtitle,
      this.leading,
      this.leadingColor,
      this.leadingFlex,
      this.trailing,
      this.trailingPress,
      this.trailingFlex,
      this.borderColor,
      this.onPress,
      this.titleSize,
      this.titlePadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color mainColor = getIceWhite();
    Color mainColor = Colors.white;

    Color secondaryColor = Colors.black;

    int maxLength = 28;

    dynamic subtitleView = subtitle;

    return CardButton(
      cardHeight: 90 * multiplyHeight,
      nulifyWidth: true,
      onPress: onPress,
      title: title.hideInfo(maxLength: maxLength),
      titleSize: titleSize,
      titleAlignment: titleAlignment,
      titleFlex: titleFlex,
      subTitle: subtitleView,
      backgroundColor: mainColor,
      borderColor: borderColor,
      titleColor: secondaryColor,
      titlePadding: titlePadding,
      subtitleColor: secondaryColor,
      leadingIconColor: leadingColor ?? secondaryColor,
      leadingIconFlex: leadingFlex ?? (leading == null ? 0 : null),
      trailingColor: secondaryColor,
      leadingIcon: leading,
      cardIntention: CardIntention.display,
      trailingIcon: trailing ?? Icons.close,
      trailingAlignment: Alignment.centerRight,
      trailingPadding: EdgeInsets.only(right: 16),
      trailingFlex: trailingFlex,
      trailingPress: trailingPress,
    );
  }
}
