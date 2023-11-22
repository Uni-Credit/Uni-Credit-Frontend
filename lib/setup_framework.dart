


import 'package:flutter/material.dart';
import 'package:framework/framework.dart';
import 'package:framework/shared_widgets/base_template/go_back_button.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:framework/shared_widgets/form_components/linked_text_input.dart';
import 'package:framework/shared_widgets/widgets/title.dart';
import 'package:uni_credit/theme/theme_colors.dart';


setupFramework() {
  TitleWidget.textColor = Colors.white;

  Framework.templateDefaults.scrollerBehaviour = ScrollerBehaviour.whole;
  Framework.templateDefaults.navbar.content =
      GoBackButton();

  LinkedTextInputStyle.defaultInputBorder =
  OutlineInputBorder(
    borderSide: BorderSide.none
  );

  TemplateScaffold.defaultBackgroundColor = ThemeColors.getBackground();
}