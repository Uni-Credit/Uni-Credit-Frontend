import 'package:flutter/cupertino.dart';

import 'item_selection.dart';
import 'item_selection_confirm_action.dart';
import 'item_selection_counter_display.dart';

class ItemViewDistributedInteraction<T> extends StatelessWidget {
  const ItemViewDistributedInteraction({
    super.key,
    required this.itemBuilder,
    required this.itemSelection,
    required this.items,
  });

  final Function(T item) itemBuilder;
  final ItemsSelection<T> itemSelection;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: itemSelection.inToggleMode,
          child: ItemsSelectionCounterDisplay<T>(
            allItems: items,
            items: itemSelection.itemsToggled,
          ),
        ),
        for (T item in items) itemBuilder(item),
        Visibility(
          visible: itemSelection.inToggleMode,
          child: ItemSelectionConfirmAction<T>(
            itemSelection: itemSelection,
          ),
        )
      ],
    );
  }
}
