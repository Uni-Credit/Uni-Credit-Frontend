import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'developer_documentation_page_body.dart';

class DeveloperDocumentationPage extends StatelessWidget {
  const DeveloperDocumentationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(body: DeveloperDocumentationPageBody());
  }
}
