import 'package:framework/atech/atech_myapp.dart';
import 'package:framework/shared_widgets/form_components/dropdown_field.dart';
import 'package:framework/shared_widgets/form_components/template_dropdown.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'language_controller.dart';

class LanguageDropdown extends StatefulWidget {
  //final ValueNotifier<Locale>? locales;
  final Color? backgroundColor;
  const LanguageDropdown({Key? key, this.backgroundColor}) : super(key: key);

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String? currentLanguageCode;

  ValueNotifier<DropdownItem?> itemSelected = ValueNotifier(null);

  @override
  initState() {
    loadLanguage();

    ATechMyApp.languageController.addListener(() {
      loadLanguage();
    });
  }

  loadLanguage() async {
    Locale currentLocale = await LanguageController.getLocale();

    if (currentLanguageCode != currentLocale.languageCode) {
      setState(() {
        currentLanguageCode = currentLocale.languageCode;
        itemSelected.value = DropdownItem(
          value: currentLanguageCode,
          displayValue:
              LanguageController.getLocaleDisplay(currentLanguageCode!),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentLanguageCode == null) {
      return Container();
    }

    return Builder(builder: (context) {
      List<DropdownItem> items = getItems();
      return DropdownField(
        itemSelected: itemSelected,
        items: items,
        styleArgs: DropdownStyleArgs(),
        onChanged: (languageCode) {
          debugPrint(languageCode);
          ATechMyApp.setLocale(context, Locale(languageCode));
          setState(() {});
        },
        displayBuilder: (DropdownBuilderArgs args) {
          return TemplateDropdown(
            args: args,
            backgroundColor: widget.backgroundColor,
          );
        },
      );
    });
  }

  List<DropdownItem> getItems() {
    List<DropdownItem> dropdownItems = [];

    debugPrint(AppLocalizationDelegate().supportedLocales.toString());
    debugPrint(currentLanguageCode.toString());
    dynamic first;
    const AppLocalizationDelegate().supportedLocales.forEach((locale) {
      DropdownItem dropdownItem = DropdownItem(
        value: locale.languageCode,
        displayValue: LanguageController.getLocaleDisplay(locale.languageCode),
      );

      if (currentLanguageCode == locale.languageCode) {
        first = dropdownItem;
        return;
      }

      dropdownItems.add(dropdownItem);
    });

    if (first != null) {
      dropdownItems.insert(0, first);
    }

    return dropdownItems;
  }
}

class LanguageItem extends StatelessWidget {
  final String language;
  const LanguageItem({
    Key? key,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenuItem(
      child: Text(language),
    );
  }
}
