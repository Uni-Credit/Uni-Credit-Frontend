import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/models/extensions/for_list.dart';

import '../../../atech/models/patient.dart';
import '../../base_template/widgets/card_button_v1.dart';
import '../../item_sizes.dart';
import '../../list_value_notifier.dart';

class ItemsSelectionCounterDisplay<T> extends StatelessWidget {
  final ListValueNotifier items;
  final List<T> allItems;
  const ItemsSelectionCounterDisplay(
      {Key? key, required this.allItems, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
      buttonSize: ItemSize.big,
      backgroundColor: Colors.grey,
      leadingIcon: CardIconData(
          icon: items.length == allItems.length
              ? Icons.check_box
              : Icons.check_box_outline_blank,
          press: () {
            if (items.length == allItems.length) {
              items.value = List<T>.from([]);
              return;
            }
            items.value = allItems.copy();
          }),
      title: CardTextContent(content: "${items.length} Selecionados."),
    );
  }
}
