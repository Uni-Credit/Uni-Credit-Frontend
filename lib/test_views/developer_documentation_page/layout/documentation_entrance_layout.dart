import 'package:flutter/cupertino.dart';
import 'package:framework/layout_definition/layout.dart';

class DocumentationEntranceConstruction extends LayoutConstruction {
  final DocumentationQuickNavigationLayout highlightsLayout;

  DocumentationEntranceConstruction({required this.highlightsLayout});
}

abstract class DocumentationEntranceLayout
    extends Layout<DocumentationEntranceConstruction> {
  const DocumentationEntranceLayout({super.key, required super.construction});
}

abstract class DocumentationQuickNavigationLayout extends StatelessWidget {
  const DocumentationQuickNavigationLayout({super.key});
}
