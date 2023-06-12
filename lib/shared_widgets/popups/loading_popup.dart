import 'dart:math';

import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/popups/template_popup.dart';

import '../item_sizes.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplatePopup(
        usesScroll: false,
        backgroundColor: Colors.white,
        popupSize: ItemSize.small,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: min(MediaQuery.of(context).size.width * 0.2, 40),
                child: const CircularProgressIndicator(
                    value: null, color: Color(0xff93467E)),
              ),
            ),
            const Text(
              "Carregando",
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
