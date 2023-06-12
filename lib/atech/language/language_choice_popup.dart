import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/atech_myapp.dart';
import 'package:framework/atech/language/language_controller.dart';

import '../../shared_widgets/base_template/widgets/card_button_v1.dart';
import '../../shared_widgets/item_sizes.dart';
import '../../shared_widgets/popups/action_content_popup.dart';
import '../../shared_widgets/popups/template_popup.dart';
import '../models/language_read.dart';
import 'language_dropdown.dart';

class LanguageChoicePopup extends StatefulWidget {
  const LanguageChoicePopup({Key? key}) : super(key: key);

  @override
  State<LanguageChoicePopup> createState() => _LanguageChoicePopupState();
}

class _LanguageChoicePopupState extends State<LanguageChoicePopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ATechMyApp.languageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ActionContentPopup(
      popupSize: ItemSize.smallish,
      content: [
        Text(
          LR.of(context).selectLanguageTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: LanguageDropdown(),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        CardButtonV1(
          width: CardDimension(itemSize: ItemSize.small),
          title: CardTextContent(content: "Ok"),
          onPress: () {
            context.router.pop();
          },
        )
      ],
    );
  }
}
