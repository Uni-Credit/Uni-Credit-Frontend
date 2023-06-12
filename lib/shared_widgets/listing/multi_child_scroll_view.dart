import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MultiChildScrollView extends StatelessWidget {
  // Multichild size is obrigatory
  late double? scrollWidth;
  late double? scrollHeight;
  final ScrollbarOrientation direction;

  final EdgeInsets? contentPadding;

  final List<Widget> children;
  late ScrollController controller;

  final Axis scrollDirection;
  final double? axisSpacing;

  final bool doubleDirection;
  final Alignment alignment;

  final double? heightSpacing;
  final ScrollController secondScrollController = ScrollController();

  MultiChildScrollView(
      {Key? key,
      double? scrollWidth,
      double? scrollHeight,
      BuildContext? context,
      ScrollController? scrollController,
      this.alignment = Alignment.center,
      this.doubleDirection = false,
      this.contentPadding,
      this.scrollDirection = Axis.vertical,
      this.direction = ScrollbarOrientation.right,
      required this.children,
      this.axisSpacing,
      this.heightSpacing})
      : super(key: key) {
    controller = scrollController ?? ScrollController();

    this.scrollHeight = scrollHeight ??
        (context != null ? MediaQuery.of(context).size.height : null);

    this.scrollWidth = scrollWidth ??
        (context == null ? null : MediaQuery.of(context).size.width);
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: controller,
      thumbVisibility: true,
      //trackVisibility: true,
      scrollbarOrientation: direction,
      child: Container(
        width: scrollWidth,
        height: scrollHeight,
        child: getListView(),
      ),
    );
  }

  Widget getListView() {
    Axis mainAxis = (direction == ScrollbarOrientation.bottom ||
            direction == ScrollbarOrientation.top)
        ? Axis.horizontal
        : Axis.vertical;

    Widget listView = SizedBox(
      width: scrollWidth,
      height: scrollHeight,
      child: ListView(
          scrollDirection: mainAxis,
          controller: controller,
          children: [
            Padding(
              padding: contentPadding ?? EdgeInsets.zero,
              child: Flex(
                  direction: scrollDirection,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    for (Widget child in children)
                      Align(
                        alignment: alignment,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: heightSpacing ?? 0),
                          child: child,
                        ),
                      )
                  ]),
            ),
          ]),
    );

    if (doubleDirection) {
      listView = SingleChildScrollView(
        scrollDirection:
            mainAxis == Axis.horizontal ? Axis.vertical : Axis.horizontal,
        child: listView,
        controller: secondScrollController,
      );
    }

    if (contentPadding != null) {
      listView =
          Padding(padding: contentPadding ?? EdgeInsets.zero, child: listView);
    }

    return listView;
  }
}
