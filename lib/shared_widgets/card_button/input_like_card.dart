import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:uni_credit/shared_widgets/form_components/form_controller_utility.dart';

import '../card_button.dart';
import '../item_sizes.dart';

class InputLikeCard extends StatelessWidget {
  final dynamic text;
  final Function() onPress;
  final dynamic iconData;
  final int? flex;
  final String? topLabel;

  final bool nullifyWidth;

  const InputLikeCard(
      {Key? key,
      required this.text,
      required this.onPress,
      this.iconData,
      this.flex,
      this.nullifyWidth = false,
      this.topLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget card = CardButton(
      title: text,
      titleSize: LabelText.fontSize(context),
      useLeadingSpacing: false,

      titlePadding: EdgeInsets.only(left: LabelText.labelLeftPadding),
      titleColor: Colors.blueAccent,
      titleFlex: 40,
      trailingFlex: iconData == null ? 0 : 8,
      trailingColor: const Color(0xff9b9b9b /*d4d4d4*/),
      //leadingIconFlex: 0,
      titleAlignment: Alignment.centerLeft,
      onPress: onPress,
      titleWeight: FontWeight.normal,
      trailingIcon: iconData,
      trailingAlignment: Alignment.centerRight,
      trailingPadding: EdgeInsets.only(right: LabelText.labelLeftPadding),
      backgroundColor: Colors.white70
      //getAppBackgroundColor()
      , //color,
      borderShape: BeveledRectangleBorder(
          side: BorderSide(color: Color(0xff9b9b9b /*d4d4d4*/), width: 0.5),
          borderRadius: BorderRadius.circular(4)),
      buttonSize: ItemSize.normal,
      nulifyWidth: flex != null || nullifyWidth,
      cardHeight: 50,
    );
/*

    Widget card = CardButtonV1(
      title: CardTextContent(content: text, padding: EdgeInsets.only(left: 6),
        color: getLight(),
        flex: 40, fontWeight: FontWeight.normal,

        alignment: Alignment.centerLeft,
      ),

      trailingIcon: CardIconData(icon: iconData, color: const Color(0xff9b9b9b/*d4d4d4*/),
          iconFlex: 8,useSpacing: false, iconPadding: EdgeInsets.only(right: 12) ),

      onPress: onPress,
      backgroundColor: getAppBackgroundColor(),//color,
      borderShape: BeveledRectangleBorder(side: BorderSide(color: Color(0xff9b9b9b/*d4d4d4*/), width: 0.5),

          borderRadius: BorderRadius.circular(4)),
    width: CardDimension(size: 100),
      height: CardDimension(size: 50),
    );*/

    if (topLabel != null) {
      card = Stack(
        children: [
          card,
          topLabel == null
              ? Container()
              : _TopLabel(
                  topLabel: topLabel!,
                ),
        ],
      );
    }

    return card;
  }
}

class _TopLabel extends StatelessWidget {
  final String topLabel;
  const _TopLabel({Key? key, required this.topLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.translationValues(8, -8, 0),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Text(
            topLabel,
            style: TextStyle(fontSize: 14, color: Colors.blueAccent
                //BrandColors.medicGreen
                ),
          ),
        ),
      ),
    );
  }
}
