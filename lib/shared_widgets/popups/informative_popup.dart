import 'dart:math';

import 'package:uni_credit/shared_widgets/popups/response_popup.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../base_template/widgets/card_button_v1.dart';
import '../card_button.dart';
import '../item_sizes.dart';
import 'action_content_popup.dart';

class InformativePopup extends StatelessWidget {
  final String? title;
  final dynamic subtitle;
  final String? confirmLabel;
  final bool? success;
  final RequestMessage? requestMessage;
  final Function()? onClickAfterClosed;
  final Axis iconAndTitleAxis;
  final ItemSize? popupSize;
  final ItemSize? popupHeight;
  final bool leftDesign;

  const InformativePopup(
      {super.key,
      this.title,
      this.subtitle,
      this.success = true,
      this.confirmLabel,
      this.onClickAfterClosed,
      this.requestMessage,
      this.iconAndTitleAxis = Axis.vertical,
      this.popupSize,
      this.popupHeight,
      this.leftDesign = false});

  @override
  Widget build(BuildContext context) {
    double basePadding = 12;

    bool useRequestMessage = requestMessage != null;

    bool? isSuccess = useRequestMessage ? requestMessage!.success : success;

    Axis titleAxis = iconAndTitleAxis;
    EdgeInsets titlePadding = EdgeInsets.zero;
    if (leftDesign) {
      titleAxis = Axis.horizontal;
      titlePadding = EdgeInsets.only(left: 12);
    }

    return ActionContentPopup(
        popupSize: popupSize,
        popupHeight: popupHeight,
        content: [
          Flex(
            direction: titleAxis,
            children: [
              _TitleElement(
                  titlePadding: titlePadding,
                  basePadding: basePadding,
                  useRequestMessage: useRequestMessage,
                  requestMessage: requestMessage,
                  title: title),
            ],
          ),
          Container(
            margin:
                EdgeInsets.only(top: basePadding, bottom: basePadding, left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: useRequestMessage
                  ? requestMessage!.subtitle
                  : subtitle.runtimeType == String
                      ? Text(
                          subtitle,
                          style: const TextStyle(
                              color: Color.fromARGB(200, 0, 0, 0)),
                        )
                      : subtitle,
            ),
          ),
        ],
        actions: [
          InformativePopupButton(
              onClickAfterClosed: onClickAfterClosed,
              confirmLabel: confirmLabel),
        ]);
  }

  IconData? getIcon(bool? isSuccess) {
    return isSuccess == null
        ? null
        : isSuccess
            ? Icons.done
            : Icons.close;
  }

  getIconColor(bool? isSuccess) {
    return Colors.blueAccent;
    /*isSuccess == null || isSuccess
        ? getUserPrimaryColor()
        : BrandColors.adminPink;*/
  }
}

class InformativePopupButton extends StatelessWidget {
  const InformativePopupButton({
    super.key,
    required this.onClickAfterClosed,
    required this.confirmLabel,
  });

  final Function()? onClickAfterClosed;
  final String? confirmLabel;

  onPress(BuildContext context) async {
    await context.router.pop();

    if (onClickAfterClosed != null) {
      onClickAfterClosed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.045,
        ),
        child: CardButtonV1(
          onPress: () => onPress(context),
          title: CardTextContent(
              content: confirmLabel ?? "Entendi", color: Colors.white),
          buttonSize: ItemSize.smallish,
        ),
      ),
    );
  }
}

class _TitleElement extends StatelessWidget {
  const _TitleElement({
    super.key,
    required this.titlePadding,
    required this.basePadding,
    required this.useRequestMessage,
    required this.requestMessage,
    required this.title,
  });

  final EdgeInsets titlePadding;
  final double basePadding;
  final bool useRequestMessage;
  final RequestMessage? requestMessage;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: titlePadding,
      child: Container(
        margin: EdgeInsets.only(
          top: basePadding,
          bottom: basePadding,
        ),
        child: Text(
          useRequestMessage ? requestMessage!.title : title!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
