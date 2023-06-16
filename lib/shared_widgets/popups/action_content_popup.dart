import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_credit/shared_widgets/base_template/size_restriction_definition/real_size_bloc.dart';
import 'package:uni_credit/shared_widgets/popups/template_popup.dart';

import '../item_sizes.dart';

class ActionContentPopup extends StatelessWidget {
  final List<Widget>? top;
  final List<Widget> content;
  final List<Widget> actions;
  final ItemSize? popupSize;
  final ItemSize? popupHeight;
  final CrossAxisAlignment? contentAlignment;
  final MainAxisAlignment? contentColumnAlignment;
  final MainAxisAlignment? actionsAlignment;

  final EdgeInsets buttonsPadding;

  final Widget Function(BuildContext context)? title;

  const ActionContentPopup({
    required this.content,
    this.top,
    this.contentAlignment,
    this.contentColumnAlignment,
    this.popupHeight,
    this.buttonsPadding = EdgeInsets.zero,
    required this.actions,
    this.popupSize,
    Key? key,
    this.title,
    this.actionsAlignment,
  }) : super(key: key);

  bool hasTop() {
    return top != null && top!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double topProportion = 0;
    double contentProportion = 3 / 4;
    double actionsProportion = 1 / 4;

    if (hasTop()) {
      topProportion = 1 / 5;
      contentProportion = 1 / 2;
      //actionsProportion = 1/4;
    }

    return TemplatePopup(
        title: title,
        popupSize: popupSize ?? ItemSize.small,
        popupHeight: popupHeight,
        backgroundColor: Colors.white,
        usesScroll: false,
        paddingSize: ItemSize.small,
        useBloc: true,
        child: BlocBuilder<SizeCubit, Size>(builder: (context, size) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: contentAlignment ?? CrossAxisAlignment.center,
            children: [
              top == null
                  ? Container()
                  : Container(
                      height: size.height * topProportion,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: top!,
                      ),
                    ),
              Container(
                height: size.height * contentProportion,
                child: Column(
                  mainAxisAlignment:
                      contentColumnAlignment ?? MainAxisAlignment.center,
                  crossAxisAlignment:
                      contentAlignment ?? CrossAxisAlignment.center,
                  children: content,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: size.height * actionsProportion,
                width: size.width,
                child: Row(
                    mainAxisAlignment:
                        actionsAlignment ?? MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: actions),
              )
            ],
          );
        }));
  }
}
