import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(body: Container());
  }
}
