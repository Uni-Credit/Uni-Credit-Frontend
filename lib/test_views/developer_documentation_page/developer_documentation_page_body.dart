import 'package:flutter/material.dart';
import 'package:uni_credit/test_views/developer_documentation_page/layout/documentation_entrance_layout.dart';
import 'package:uni_credit/test_views/developer_documentation_page/widgets/documentation_entrance/documentation_entrance.dart';
import 'package:uni_credit/test_views/developer_documentation_page/widgets/documentation_section_list.dart';

import '../../shared_widgets/widgets/app_container.dart';

class DeveloperDocumentationPageBody extends StatelessWidget {
  const DeveloperDocumentationPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        child: DocumentationEntrance(
      construction: DocumentationEntranceConstruction(
          highlightsLayout: DocumentationSectionList()),
    ));
  }
}
