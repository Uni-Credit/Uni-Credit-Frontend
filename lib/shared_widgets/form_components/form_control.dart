import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/card_button/icon_action_card_button.dart';

import '../responsive/media_queries.dart';
import '../base_template/go_back_button.dart';

class FormControlBackground extends StatelessWidget {
  const FormControlBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class FormControlContent extends StatelessWidget {
  final Function() goBackCommand;
  final Function()? confirmCommand;

  final bool isEditMode;
  final bool useConfirmInMobile;
  final bool useGoBack;

  final Function() onGoBack;

  const FormControlContent(
      {super.key,
      required this.goBackCommand,
      required this.confirmCommand,
      this.useConfirmInMobile = false,
      this.useGoBack = true,
      required this.onGoBack,
      this.isEditMode = false});

  Widget getFormButton(context, command,
      {required width,
      required backgroundColor,
      required label,
      required labelColor,
      required borderColor,
      dynamic mobileReplacement}) {
    if (mobileReplacement == null && isMobile()) {
      return Container();
    }

    return SizedBox(
      width: width,
      height: min(MediaQuery.of(context).size.height * 0.25, 50),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(5),
            )),
          ),
          onPressed: command,
          child: isMobile()
              ? mobileReplacement
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                  ),
                )),
    );
  }

  String getActionText({bool showDetails = false}) {
    return (isEditMode ? "Editar" : "Cadastrar") +
        (!showDetails
            ? ""
            : (returnAppropriateGlobal(mobile: "", defaultResult: " usuário")));
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry buttonPadding =
        EdgeInsets.all(MediaQuery.of(context).size.width * 0.05);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        children: [
          Visibility(
            visible: useGoBack,
            child: Flexible(
                flex: 1,
                child: GoBackButton(
                  defaultGoBack: () {
                    onGoBack();
                  },
                )),
          ),
          Flexible(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconActionCardButton(
                    content: "Cancelar",
                    icon: Icon(
                      Icons.close,
                      color: Colors.blueAccent,
                    ),
                    invertColors: true,
                    borderColor: const Color.fromRGBO(13, 151, 173, 1),
                    onPress: goBackCommand),

                //
                isMobile() && !useConfirmInMobile
                    ? Container()
                    : SizedBox(width: 24),
                //
                useConfirmInMobile || !isMobile()
                    ? IconActionCardButton(
                        content: getActionText(showDetails: true),
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        contentColor: Colors.white,
                        borderColor: const Color.fromRGBO(204, 204, 204, 1),
                        onPress: confirmCommand)
                    : Container()
                /*  useConfirmInMobile && isMobile()
                    ?  : Tooltip(
                        message: getActionText(showDetails: true),
                        child: getFormButton(
                          context,
                          confirmCommand,
                          width: 180,
                          label: getActionText(),
                          backgroundColor: confirmCommand == null
                              ? const Color(0xffcccccc)
                              : BrandColors.medicGreen,
                          label

                        ),
                      )*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
