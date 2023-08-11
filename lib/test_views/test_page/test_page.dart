import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'test_page_body.dart';


class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(body: TestPageBody());
  }
}
