import 'package:framework/shared_widgets/form_components/dropdown_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../base_template/widgets/card_button_v1.dart';
import '../item_sizes.dart';

class TemplateDropdown extends StatelessWidget {
  final DropdownBuilderArgs args;
  final Color? backgroundColor;
  const TemplateDropdown({Key? key, required this.args, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
      title: CardTextContent(content: args.selectedItem.display),
      backgroundColor: backgroundColor ?? Color(0xec5fcee5),
      buttonSize: ItemSize.normal,
      width: CardDimension(size: 360),
      trailingIcon: CardIconData(icon: Icons.arrow_drop_down_sharp),
      leadingIcon: CardIconData(),
    );
  }
}
