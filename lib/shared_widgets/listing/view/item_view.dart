import 'package:flutter/cupertino.dart';

import '../../../atech/views/user_listing/list_patients_page/list_patients_page.dart';
import 'item_selection.dart';

class ItemViewBuilderArgs {
  Function() press;
  Function() toggle;
  bool isSelected;
  bool canBeToggled;
  ItemViewBuilderArgs(
      {required this.toggle,
      required this.canBeToggled,
      required this.press,
      required this.isSelected});
}

class ItemView<T> extends StatefulWidget {
  const ItemView(
      {super.key,
      required this.itemsSelection,
      required this.item,
      required this.cardBuilder});

  final ItemsSelection<T>? itemsSelection;
  final T item;
  final Widget Function(ItemViewBuilderArgs args) cardBuilder;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  toggleItem() {
    debugPrint("item toggle");
    debugPrint(widget.item.toString());
    if (widget.itemsSelection == null) {
      debugPrint("itemsSelection null");
      return;
    }
    setState(() {
      if (widget.itemsSelection!.itemsToggled.contains(widget.item)) {
        widget.itemsSelection!.itemsToggled.remove(widget.item);

        debugPrint("item detoggled");
        return;
      }

      debugPrint("item toggled");
      widget.itemsSelection!.itemsToggled.add(widget.item);
    });
  }

  selectedItem() {
    if (widget.itemsSelection!.pressed == null) {
      return;
    }
    widget.itemsSelection!.pressed!(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: widget.cardBuilder(ItemViewBuilderArgs(
          isSelected: widget.itemsSelection!.itemsToggled.contains(widget.item),
          toggle: toggleItem,
          canBeToggled: widget.itemsSelection?.inToggleMode ?? false,
          press: selectedItem)),
    );
  }
}
