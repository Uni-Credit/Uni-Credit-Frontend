import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/framework.dart';
import 'package:framework/models/extensions/for_build_context.dart';
import 'package:framework/shared_widgets/base_template/template_defaults.dart';

import 'language/language_dropdown.dart';

configureDefaultATechFrameworkSettings() {
  Framework.templateDefaults.body.overlay =
      (OverlayConfiguration overlayConfiguration) {
    BuildContext context = overlayConfiguration.context;
    return Visibility(
      visible: overlayConfiguration.useOverlay,
      child: Container(
        height: context.height * 0.85,
        width: context.width * 0.85,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Container(
              width: 150,
              child: LanguageDropdown(
                  backgroundColor: Colors.grey.withAlpha(120))),
        ),
      ),
    );
  };
}
