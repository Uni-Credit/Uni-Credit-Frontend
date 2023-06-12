import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/listing/view/item_selection.dart';

import '../../../../shared_widgets/base_template/widgets/card_button_v1.dart';
import '../../../../shared_widgets/list_value_notifier.dart';
import '../../../../shared_widgets/listing/view/item_view.dart';
import '../../../../shared_widgets/listing/view/item_view_card.dart';
import '../../../../shared_widgets/listing/view/item_view_interaction_page.dart';
import '../../../models/health_professional.dart';
import '../user_search_mechanism.dart';

class ListHealthProfessionalConstruction {
  final Function(dynamic)? onPressItem;

  ListHealthProfessionalConstruction({this.onPressItem});
}

class ListHealthProfessionalPage extends StatefulWidget {
  final ListHealthProfessionalConstruction? construction;

  const ListHealthProfessionalPage({Key? key, this.construction})
      : super(key: key);

  @override
  State<ListHealthProfessionalPage> createState() =>
      _ListHealthProfessionalPageState();
}

class _ListHealthProfessionalPageState
    extends State<ListHealthProfessionalPage> {
  ListValueNotifier<HealthProfessional> professionals = ListValueNotifier([]);

  loadProfessionals() async {
    professionals.value = HealthProfessional.mock();
  }

  @override
  Widget build(BuildContext context) {
    ItemsSelection<HealthProfessional> itemsSelection =
        ItemsSelection<HealthProfessional>(
            canChangeToggle: false, pressed: widget.construction?.onPressItem);

    return ItemViewInteractionPage<HealthProfessional>(
      construction: ItemsViewInteractionConstruction<HealthProfessional>(
        loadItems: loadProfessionals,
        itemSelection: itemsSelection,
        itemBuilder: (professional) {
          return ItemView<HealthProfessional>(
              itemsSelection: itemsSelection,
              item: professional,
              cardBuilder: (args) {
                return ItemViewDefaultCard(
                  args: args,
                  title: CardTextContent(content: professional.name),
                );
              });
        },
        items: professionals,
      ),
    );
  }
}
