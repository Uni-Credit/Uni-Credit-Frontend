import 'package:flutter/cupertino.dart';

import '../../base_template/widgets/card_button_v1.dart';
import 'item_selection.dart';

class ItemSelectionConfirmAction<T> extends StatelessWidget {
  final ItemsSelection<T> itemSelection;
  const ItemSelectionConfirmAction({Key? key, required this.itemSelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
        onPress: itemSelection.onToggleSelection == null
            ? null
            : () => itemSelection
                .onToggleSelection!(itemSelection.itemsToggled.value),
        active: !itemSelection.itemsToggled.isEmpty,
        cardIntention: CardIntention.action,
        title: CardTextContent(
          content: "Confirmar",
        ));
  }
}
