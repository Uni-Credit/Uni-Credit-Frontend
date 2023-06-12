import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base_template/widgets/card_button_v1.dart';
import 'item_view.dart';

// Very simple implementation of card for ItemView Card Builder
class ItemViewDefaultCard extends StatelessWidget {
  final ItemViewBuilderArgs args;
  final CardTextContent title;
  const ItemViewDefaultCard({Key? key, required this.args, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
      backgroundColor: args.isSelected ? Colors.green : null,
      leadingIcon: CardIconData(),
      trailingIcon: args.canBeToggled
          ? CardIconData(
              size: 24,
              press: args.toggle,
              icon: args.isSelected
                  ? Icons.check_box
                  : Icons.check_box_outline_blank)
          : CardIconData(),
      title: title,
      onPress: args.canBeToggled ? args.toggle : args.press,
    );
  }
}
