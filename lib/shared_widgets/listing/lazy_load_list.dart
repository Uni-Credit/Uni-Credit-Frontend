import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/list_value_notifier.dart';

import '../../requests/request_process.dart';
import '../../requests/widgets/request_status_display.dart';
import 'multi_child_scroll_view.dart';

class LoadListProcess<T> {
  final RequestProcess? process;
  final ListValueNotifier<T> items;
  final ValueNotifier<int>? pageValue;

  final Function() updateData;

  LoadListProcess({
    required this.process,
    required this.items,
    required this.pageValue,
    required this.updateData,
  });
}

class LoadListDisplay<T> {
  final Widget Function(T)? itemBuilder;
  final Widget Function()? builder;
  final Map<RequestStatus, Map<String, dynamic>>? responseInfo;
  LoadListDisplay({this.itemBuilder, this.builder, this.responseInfo}) {
    assert(builder != null || itemBuilder != null);
  }
}

class LazyLoadList extends StatefulWidget {
  final ScrollController? scrollController;
  final double width;
  final double height;
  final double? heightSpacing;

  final LoadListProcess loadListProcess;
  final LoadListDisplay loadListDisplay;

  final Alignment? alignment;

  LazyLoadList(
      {required this.width,
      required this.height,
      Key? key,
      this.heightSpacing,
      this.alignment,
      required this.loadListProcess,
      this.scrollController,
      required this.loadListDisplay})
      : super(key: key) {}

  @override
  State<LazyLoadList> createState() => _LazyLoadListState();

  static defaultUpdateItems(int? lastPage, ValueNotifier<int> pageValue,
      Function() listBuilder, Function(dynamic) listUpdate) async {
    if (lastPage != null && pageValue.value >= lastPage) {
      return;
    }

    final result = await listBuilder();

    if (result != null) {
      listUpdate(result);
    }
  }
}

class _LazyLoadListState extends State<LazyLoadList> {
  ScrollController scrollController = ScrollController();
  initState() {
    super.initState();

    if (widget.scrollController != null) {
      scrollController = widget.scrollController!;
    }
    scrollController.addListener(() {
      if (!mounted) return;
      checkForScrollUpdate();
    });

    setState(() {
      widget.loadListProcess.updateData();
    });
  }

  checkForScrollUpdate() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.loadListProcess.updateData();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: RequestStatusDisplay(
          responseInfo: widget.loadListDisplay.responseInfo,
          padding: const EdgeInsets.only(top: 32),
          processRequest: widget.loadListProcess.process,
          forceSuccessWidget: widget.loadListProcess.pageValue == null
              ? false
              : (widget.loadListProcess.pageValue!.value > 1),
          successWidget: widget.loadListProcess.items.isEmpty
              ? Container()
              : MultiChildScrollView(
                  alignment: widget.alignment ?? Alignment.center,
                  scrollController: scrollController,
                  scrollWidth: widget.width,
                  scrollHeight: widget.height,
                  axisSpacing: widget.heightSpacing,
                  children: [
                      ...widget.loadListDisplay.itemBuilder == null
                          ? [widget.loadListDisplay.builder!()]
                          : widget.loadListProcess.items.map((item) =>
                              widget.loadListDisplay.itemBuilder!(item)),
                      const SizedBox(
                        height: 40,
                      )
                    ])),
    );
  }
}
