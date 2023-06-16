import 'package:flutter/cupertino.dart';
import 'package:uni_credit/test_views/developer_documentation_page/layout/documentation_entrance_layout.dart';

class DocumentationEntrance extends DocumentationEntranceLayout {
  const DocumentationEntrance({Key? key, required super.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return construction.highlightsLayout;
  }
}
