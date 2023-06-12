import 'dart:math';

import 'package:framework/shared_widgets/base_template/size_restriction_definition/restricted_element_definition.dart';
import 'package:framework/shared_widgets/base_template/template_background.dart';
import 'package:framework/shared_widgets/base_template/template_defaults.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/cupertino.dart';

import '../../framework.dart';
import '../listing/multi_child_scroll_view.dart';
import '../responsive/media_queries.dart';

class BodyLayoutDefinition {
  final Widget background;
  final NavbarConfiguration navbarConfiguration;
  final AppbarConfiguration appbarConfiguration;
  final RestrictedElementDefinition elementDefinition;
  final ScrollerBehaviour scrollBehaviour;

  final Widget body;
  final bool useDefaultPadding;
  final Widget Function(BuildContext context, double realWidth, Widget body)?
      bodyParent;
  BodyLayoutDefinition({
    required this.background,
    required this.appbarConfiguration,
    required this.scrollBehaviour,
    required this.navbarConfiguration,
    required this.elementDefinition,
    required this.body,
    required this.useDefaultPadding,
    required this.bodyParent,
  });
}

class TemplateBodyLayout extends StatefulWidget {
  final BodyLayoutDefinition definition;

  const TemplateBodyLayout({
    required this.definition,
    Key? key,
  }) : super(key: key);

  @override
  State<TemplateBodyLayout> createState() => _TemplateBodyLayoutState();
}

class _TemplateBodyLayoutState extends State<TemplateBodyLayout> {
  @override
  void initState() {
    super.initState();
  }

  double getBodyHeight(navbarPadding) {
    double bodyHeight = MediaQuery.of(context).size.height -
        (widget.definition.appbarConfiguration.ignorePadding
            ? 0
            : Framework.templateDefaults.appbar.height ?? 0);

    if (!widget.definition.navbarConfiguration.ignoreNavbarPadding) {
      bodyHeight -= navbarPadding;
    }

    if (widget.definition.navbarConfiguration.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.navbar.padding;
    }

    if (widget.definition.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.body.topPadding;
    }

    return bodyHeight;
  }

  @override
  Widget build(BuildContext context) {
    Widget body = widget.definition.body;

    // #TODO  WHEN USING PATIENT HEADER, SPACE IN MOBILE OVERFLOWS

    EdgeInsets bodyPadding = widget.definition.useDefaultPadding
        ? EdgeInsets.only(top: Framework.templateDefaults.body.topPadding)
        : EdgeInsets.zero;

    double navbarPadding =
        (widget.definition.navbarConfiguration.ignoreNavbarPadding
            ? 0
            : widget.definition.navbarConfiguration.height);

    if (widget.definition.navbarConfiguration.useTwoNavbars) {
      double extraNavbarPadding = widget.definition.navbarConfiguration.height;
      navbarPadding += extraNavbarPadding;
    }

    bodyPadding = bodyPadding.copyWith(
        left: Framework.templateDefaults.body.horizontalPadding,
        right: Framework.templateDefaults.body.horizontalPadding,
        top: bodyPadding.top + navbarPadding);

    //bodyPadding = EdgeInsets.zero;
    double bodyHeight = getBodyHeight(navbarPadding);

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      body = Container(
        child: MultiChildScrollView(
            doubleDirection: screenModelBasedOnWidth() == DeviceType.mobile,
            scrollWidth: widget.definition.elementDefinition.realWidth,
            scrollHeight: bodyHeight,
            children: [
              body, /*
              Padding(
                padding: EdgeInsets.only(
                    top: widget.parent.navbarConfiguration.useTwoNavbars
                        ? 12
                        : 0),
                child: body,
              )*/
            ]),
      );
    }

    List<Widget> mainElements = [
      widget.definition.elementDefinition.getElement(
          restrictedHeight: max(bodyHeight, 400),
          content: Column(
            children: [
              Container(
                child: Padding(
                  padding: bodyPadding,
                  child: Container(
                      //color: Colors.blue,

                      child: body),
                ),
              )
            ],
          ),
          parentBody: widget.definition.bodyParent,
          background: widget.definition.background)
    ];

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      return SizedBox(
          width: widget.definition.elementDefinition.realWidth,
          // height: widget.parent.nullifyHeight ? null : bodyHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mainElements,
          ));
    }

    return MultiChildScrollView(
        doubleDirection: true,
        scrollWidth: widget.definition.elementDefinition.realWidth,
        scrollHeight: bodyHeight,
        children: mainElements);
  }
}
