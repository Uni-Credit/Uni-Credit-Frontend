import 'package:flutter/cupertino.dart';
import 'package:uni_credit/layout_definition/layout.dart';

class DocumentationSectionConstruction extends LayoutConstruction {
  final SectionDescriptionLayout sectionDescriptionLayout;

  DocumentationSectionConstruction({required this.sectionDescriptionLayout});
}

abstract class DocumentationSectionLayout<DocumentationSectionConstruction>
    extends Layout {
  const DocumentationSectionLayout({super.key, required super.construction});
}

// Brief explanation of the section
abstract class SectionDescriptionLayout extends StatelessWidget {
  const SectionDescriptionLayout({super.key});
}
