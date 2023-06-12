import 'package:flutter/cupertino.dart';
import 'package:framework/atech/views/entrance_page/presentation_element_layout.dart';
import 'package:framework/atech/views/entrance_page/entrance_actions/entrance_actions_layout.dart';
import 'package:framework/layout_definition/layout.dart';

class EntranceConstruction extends LayoutConstruction {
  final PresentationElementLayout? presentationElementLayout;
  final EntranceActionsLayout? actionElementLayout;

  EntranceConstruction(
      {required this.actionElementLayout,
      required this.presentationElementLayout});
}

abstract class EntranceLayout extends Layout<EntranceConstruction> {
  const EntranceLayout({super.key, required super.construction});
}
