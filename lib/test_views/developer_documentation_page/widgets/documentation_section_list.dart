import 'package:flutter/cupertino.dart';
import 'package:framework/test_views/developer_documentation_page/layout/documentation_entrance_layout.dart';

class DocumentationSectionList extends DocumentationQuickNavigationLayout {
  const DocumentationSectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Item de seção 1',
      'Item de seção 2',
      'Item de seção 3',
      'Item de seção 4',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [for (String item in items) Text(item)],
    );
  }
}
