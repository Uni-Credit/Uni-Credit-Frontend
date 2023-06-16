import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/models/model_color.dart';
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';
import '../base_template/go_back_button.dart';
import '../base_template/widgets/card_button_v1.dart';
import '../form_components/form_controller_utility.dart';
import '../item_sizes.dart';
import 'action_content_popup.dart';

class Component {
  final dynamic content;
  final bool useSpacing;

  Component({required this.content, this.useSpacing = false});

  asWidget({Widget? ifNotWidget}) {
    return (content is Widget ? content : ifNotWidget)!;
  }
}

class ConfirmationPopup<T> extends StatelessWidget {
  final Component title;

  final dynamic subtitle;

  final Function(T) onSelect;

  final String confirmLabel;

  final String cancelLabel;

  final confirmValue;
  final cancelValue;

  final ModelColor? buttonColor;

  final bool usesCloseButton;

  const ConfirmationPopup(
      {super.key,
      required this.title,
      this.subtitle,
      required this.onSelect,
      this.buttonColor,
      this.confirmLabel = "Confirmar",
      this.cancelLabel = "Cancelar",
      this.usesCloseButton = false,
      this.confirmValue = true,
      this.cancelValue = false});

  static Function(dynamic value) followUp(
      {required BuildContext context,
      required Widget Function(BuildContext context) followUpBuilder}) {
    return (value) async {
      await context.router.pop();
      if (value) {
        showDialog(context: context, builder: followUpBuilder);
        return;
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    CommonButtonUtility buttonUtility =
        const CommonButtonUtility(width: 100, height: 32);

    double basePadding = 12;

    return ActionContentPopup(
        popupHeight: ItemSize.smallish,
        contentAlignment: CrossAxisAlignment.start,
        contentColumnAlignment: MainAxisAlignment.start,
        top: !usesCloseButton
            ? null
            : [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [GoBackButton(icon: Icons.close)],
                  ),
                ),
              ],
        content: [
          (subtitle == null && !title.useSpacing)
              ? Container()
              : Spacer(
                  flex: 1,
                ),
          Flexible(
            flex: 2,
            child: Container(
                margin: EdgeInsets.only(
                  top: basePadding,
                  bottom: basePadding,
                ),
                child: title.asWidget(
                  ifNotWidget: Text(
                    title.content,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
          subtitle == null
              ? Container()
              : Flexible(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: basePadding,
                      bottom: basePadding,
                    ),
                    child: subtitle.runtimeType == String
                        ? Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: LabelText.fontSize(context),
                            ),
                          )
                        : subtitle,
                  ),
                ),
        ],
        actions: [
          CancelConfirmButtons<T>(
              buttonUtility: buttonUtility,
              onSelect: onSelect,
              cancelLabel: cancelLabel,
              confirmLabel: confirmLabel,
              confirmValue: confirmValue,
              cancelValue: cancelValue,
              buttonColor: buttonColor)
        ]);
  }
}

class CancelConfirmButtons<T> extends StatelessWidget {
  final CommonButtonUtility buttonUtility;
  final Function(T) onSelect;
  final String cancelLabel;
  final String confirmLabel;

  final confirmValue;
  final cancelValue;

  final FormValidationController? formController;
  final ModelColor? buttonColor;
  const CancelConfirmButtons(
      {Key? key,
      required this.buttonUtility,
      required this.onSelect,
      required this.cancelLabel,
      required this.confirmLabel,
      required this.cancelValue,
      required this.confirmValue,
      this.formController,
      this.buttonColor})
      : super(key: key);

  getConfirmAction() {
    confirmAction() => onSelect(confirmValue);
    return formController != null
        ? (formController!.getLastValidationState() ? confirmAction : null)
        : confirmAction;
  }

  static ModelColor defaultImportantColors =
      ModelColor(color: Colors.red, contrastColor: Colors.white);

  @override
  Widget build(BuildContext context) {
    double widthMultiply = 1.3;

    EdgeInsets textPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    return Column(
      children: [
        Spacer(
          flex: 2,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CardButtonV1(
                buttonSize: ItemSize.minimal,
                onPress: () => onSelect(cancelValue),
                //theme: "cancel",
                backgroundColor: buttonColor?.contrast ?? Colors.white,
                title: CardTextContent(
                  content: cancelLabel,
                  padding: textPadding,
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(13, 151, 173, 1),
                ),
              ),
            ),
            CardButtonV1(
              buttonSize: ItemSize.minimal,
              //theme: "confirm",

              backgroundColor: buttonColor?.color,
              onPress: getConfirmAction(),
              //leadingIcon: CardIconData(icon: Icons.add),
              title: CardTextContent(
                content: confirmLabel,
                padding: textPadding,
                color: Colors.white,
              ),
            )
          ],
        ),
        Spacer()
      ],
    );
  }
}
