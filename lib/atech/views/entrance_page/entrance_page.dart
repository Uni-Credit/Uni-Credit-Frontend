import 'package:auto_route/auto_route.dart';
import 'package:framework/atech/atech_myapp.dart';
import 'package:framework/atech/language/language_choice_popup.dart';
import 'package:framework/atech/language/language_controller.dart';
import 'package:framework/atech/language/language_dropdown.dart';
import 'package:framework/atech/models/language_read.dart';
import 'package:framework/atech/views/entrance_page/presentation_element_layout.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/popups/template_popup.dart';

import '../../../shared_widgets/item_sizes.dart';
import 'entrance_actions/entrance_actions_controller.dart';
import 'entrance_page_body.dart';

class EntrancePageConstruction {
  EntranceActionsController actionsController;
  Image? image;
  PresentationElementLayout? presentationElementLayout;
  EntrancePageConstruction(
      {required this.actionsController,
      this.image,
      this.presentationElementLayout});
}

class EntrancePage extends StatefulWidget {
  final EntrancePageConstruction construction;
  const EntrancePage({Key? key, required this.construction}) : super(key: key);

  @override
  State<EntrancePage> createState() => _EntrancePageState();
}

class _EntrancePageState extends State<EntrancePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadLanguage();

    ATechMyApp.languageController.addListener(() {
      setState(() {});
    });
  }

  loadLanguage() async {
    bool wasSelected = await LanguageController.localeWasSelected();

    if (!wasSelected || true) {
      LanguageChoicePopup().showDialogInNextFrame(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        useOverlay: false,
        useDefaultPadding: false,
        navbarConfig: NavbarConfiguration(
            usesDefaultNavbar: false, ignoreNavbarPadding: true),
        appbarConfig:
            AppbarConfiguration(useDefault: false, ignorePadding: true),
        body: EntrancePageBody(
          construction: widget.construction,
        ));
  }
}
