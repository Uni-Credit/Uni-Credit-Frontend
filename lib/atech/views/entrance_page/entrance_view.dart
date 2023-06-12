import 'package:flutter/material.dart';
import 'package:framework/atech/views/entrance_page/layout/entrance_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/models/extensions/for_build_context.dart';
import 'package:framework/shared_widgets/responsive/responsive.dart';

import 'widgets/atech_about_display.dart';

class EntranceView extends EntranceLayout {
  const EntranceView({Key? key, required super.construction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return ResponsiveWidget(
      mobile: Column(
        children: [
          Container(
              alignment: Alignment.center,
              height: context.height * 0.35,
              child: construction.presentationElementLayout),
          Container(
              alignment: Alignment.bottomCenter,
              height: context.height * 0.4,
              child: construction.actionElementLayout),
        ],
      ),
      defaultWidget: ScreenContainedEntrancePage(
        construction: construction,
      ),
    );
  }
}

class ScreenContainedEntrancePage extends StatelessWidget {
  const ScreenContainedEntrancePage({
    super.key,
    required this.construction,
  });

  final EntranceConstruction construction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Flexible(
            flex: 3,
            child: construction.presentationElementLayout ?? Container(),
          ),
          Spacer(
            flex: 3,
          ),
          construction.actionElementLayout == null
              ? Container()
              : Flexible(flex: 3, child: construction.actionElementLayout!),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ATechAboutDisplay(),
          )
        ],
      ),
    );
  }
}
