


import 'package:flexible_structures/widgets/base_templates/framework.dart';
import 'package:flexible_structures/widgets/base_templates/go_back_button.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:form_components/form_components/linked_text_input.dart';
import 'package:uni_credit/theme/theme_colors.dart';


setupFramework() {

  Framework.templateDefaults.scrollerBehaviour = ScrollerBehaviour.whole;
  Framework.templateDefaults.navbar.content =
      GoBackButton();

  LinkedTextInputStyle.defaultInputBorder =
  OutlineInputBorder(
    borderSide: BorderSide.none
  );

  TemplateScaffold.defaultBackgroundColor = ThemeColors.getBackground();
}