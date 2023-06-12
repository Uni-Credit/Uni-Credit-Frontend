import 'package:flutter/cupertino.dart';
import 'package:flutter/src/material/tab_controller.dart';

class TabGroupContainer extends StatelessWidget {
  final List<Widget> tabItems;
  final bool combineItems;
  final TabController? tabController;
  final Widget? tabTop;

  const TabGroupContainer(
      {Key? key,
      required this.tabItems,
      required this.combineItems,
      required this.tabController,
      this.tabTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (combineItems) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tabItems,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tabTop ?? Container(),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: tabItems[tabController?.index ?? 0],
        ),
      ],
    );
  }
}
