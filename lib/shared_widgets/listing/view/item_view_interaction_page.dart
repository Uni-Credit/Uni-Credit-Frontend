import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/requests/request_process.dart';
import 'package:uni_credit/requests/widgets/request_status_display.dart';
import 'package:uni_credit/shared_widgets/list_value_notifier.dart';
import 'package:uni_credit/shared_widgets/listing/view/user_search_mechanism.dart';

import '../../base_template/template_scaffold.dart';
import '../../base_template/widgets/card_button_v1.dart';
import 'item_selection.dart';
import 'item_view_distributed_interaction.dart';

class ItemsViewInteractionConstruction<T> {
  final ItemsSelection<T> itemSelection;
  final Function(T) itemBuilder;

  // Describes the action that will use the toggle option
  final String? labelForVinculation;
  final ListValueNotifier<T>? items;
  final Function() loadItems;

  ItemsViewInteractionConstruction({
    required this.loadItems,
    required this.itemSelection,
    required this.itemBuilder,
    required this.items,
    this.labelForVinculation,
  });
}

class ItemViewInteractionPage<T> extends StatefulWidget {
  final ItemsViewInteractionConstruction<T> construction;
  const ItemViewInteractionPage({
    Key? key,
    required this.construction,
  }) : super(key: key);

  @override
  State<ItemViewInteractionPage> createState() =>
      _ItemViewInteractionPageState<T>();
}

class _ItemViewInteractionPageState<T>
    extends State<ItemViewInteractionPage<T>> {
  RequestProcess? process;
  initState() {
    process = RequestProcess.from(widget.construction.loadItems());
  }

  changeToggleMode() {
    setState(() {
      widget.construction.itemSelection.changeToggleMode();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        useDefaultPadding: true,
        navbarConfig: widget.construction.itemSelection.canChangeToggle
            ? NavbarConfiguration(
                appending: _NavbarButton(
                    press: changeToggleMode, construction: widget.construction),
              )
            : null,
        body: Column(
          children: [
            UserSearchMechanism(onSearch: (search) {}),
            RequestStatusDisplay(
                processRequest: process,
                successWidget: ItemViewInteractionPageBody<T>(
                  construction: widget.construction,
                )),
          ],
        ));
  }
}

class ItemViewInteractionPageBody<T> extends StatelessWidget {
  final ItemsViewInteractionConstruction<T> construction;
  const ItemViewInteractionPageBody({Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemViewDistributedInteraction<T>(
      items: construction.items?.value ?? [],
      itemSelection: construction.itemSelection,
      itemBuilder: construction.itemBuilder,
    );
  }
}

class _NavbarButton extends StatelessWidget {
  final Function() press;
  final ItemsViewInteractionConstruction construction;
  const _NavbarButton({
    super.key,
    required this.press,
    required this.construction,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CardButtonV1(
              width: CardDimension(size: 220),
              leadingIcon: CardIconData(icon: Icons.add),
              backgroundColor: construction.itemSelection.inToggleMode
                  ? Colors.greenAccent
                  : Colors.blueAccent,
              trailingIcon: CardIconData(),
              title: CardTextContent(content: construction.labelForVinculation),
              onPress: press,
            ),
          ],
        ),
      ),
    );
  }
}
