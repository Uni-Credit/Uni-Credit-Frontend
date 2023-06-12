import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension PopupWidgetExtension on Widget {
  showDialogWithWidget(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return this;
        });
  }

  showDialogInNextFrame(BuildContext context) {
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      showDialogWithWidget(context);
    });
  }
}
