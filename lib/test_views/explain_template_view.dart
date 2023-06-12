import 'package:framework/models/extensions/for_build_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/base_template/template_scaffold.dart';

class ExplainTemplateView extends StatelessWidget {
  const ExplainTemplateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(
      color: Colors.white,
    );
    return TemplateScaffold(
        navbarConfig: NavbarConfiguration(
            navbar: Text(
          'navbar',
          style: defaultStyle,
        )),
        appbarConfig: AppbarConfiguration(
            content: Container(
          child: Expanded(
              child: Container(
                  color: Colors.blue,
                  child: Text(
                    'app bar',
                    style: defaultStyle,
                  ))),
        )),
        background: Container(
          width: context.width,
          height: context.height,
          color: Colors.red,
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              'background',
              style: defaultStyle,
            ),
          ),
        ),
        body: Container(
            width: context.width,
            height: context.height,
            color: Colors.green,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Entrance',
                  style: defaultStyle,
                ))));
  }
}
