import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/shared_widgets/padding_bloc.dart';

import '../card_button.dart';
import '../item_sizes.dart';
import '../responsive/media_queries.dart';

class PopupNavbar extends StatelessWidget {
  final List<Map<String, dynamic>> actions;
  final CommonButtonUtility? commonButtonUtility;
  final bool hasCloseButton;

  final String? label;
  final int? labelMaxLines;
  final int? informationFlex;

  PopupNavbar(
      {super.key,
      required this.actions,
      this.hasCloseButton = true,
      this.label,
      this.commonButtonUtility,
      this.labelMaxLines = 1,
      this.informationFlex,
      Map<String, dynamic>? customStyles}) {
    styles = customStyles ?? styles;
  }

  Map<String, dynamic> styles = {
    "negative": {
      "borderColor": const Color.fromRGBO(13, 151, 173, 1),
      "backgroundColor": Color(0xffeeeeee),
      "iconColor": const Color.fromRGBO(13, 151, 173, 1),
      "textColor": const Color.fromRGBO(13, 151, 173, 1),
      "icon": Icons.delete
    },
    "positive": {
      "icon": Icons.done,
      "borderColor": const Color.fromRGBO(13, 151, 173, 1),
      "iconColor": Colors.white,
      "textColor": Colors.white,
      "backgroundColor": const Color.fromRGBO(13, 151, 173, 1),
    }
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
                flex: informationFlex ?? 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*
                        GoBackButton(),
                        */
                    Flexible(
                      flex: 1,
                      child: Visibility(
                        child: IconButton(
                          iconSize: 28,
                          alignment: Alignment.center,
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: returnAppropriateGlobal(
                                defaultResult: 16.0, mobile: 4)),
                        child: Text(
                          textAlign: TextAlign.start,
                          label ?? "Detalhes",
                          maxLines: labelMaxLines,
                          style: TextStyle(
                              fontSize: max(
                                  min(20,
                                      MediaQuery.of(context).size.width * 0.02),
                                  12),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )),
            Flexible(
              flex: 1,
              child: BlocBuilder<PaddingBloc, EdgeInsets>(
                  builder: (context, globalPadding) {
                List<Widget> buttons = [];

                for (Map<String, dynamic> action in actions) {
                  buttons.add(Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: globalPadding.left / 2,
                    ),
                    child: buildActionButton(context, action),
                  ));
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: buttons,
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(context, action) {
    String actionStyle =
        action.containsKey('style') ? action['style'] : 'positive';

    Map<String, dynamic> style = styles[actionStyle];

    Color disabledColor = Color(0xffcccccc);

    bool isDisabled = action['function'] == null;

    Widget? button = action['button'];

    if (button != null) {
      return button;
    }
    Widget cardButton = CardButton(
      commonButtonUtility: commonButtonUtility,
      buttonSize: ItemSize.small,
      cardWidth: returnAppropriateGlobal(
          defaultResult: null,
          //
          //
          mobile: 30),
      title: Container(
        alignment: AlignmentDirectional.center,
        child: Text(
            returnAppropriateGlobal(defaultResult: action['name'], mobile: ""),
            style: TextStyle(color: style['textColor'])),
      ),
      titleFlex: returnAppropriateGlobal(defaultResult: null, mobile: 0),
      leadingIcon: action.containsKey('icon') ? action['icon'] : style['icon'],
      leadingIconColor: style['iconColor'],
      useLeadingSpacing: !isMobile(),

      // #TODO remember: make a better solution
      // probably should have tried making it in card button v1
      leadingIconFlex: isMobile() ? 100 : null,

      leadingAlignment: Alignment.center,
      mainAxisAlignment: isMobile() ? MainAxisAlignment.center : null,
      useTrailingSpacing: !isMobile(),
      onPress: action['function'],
      backgroundColor: isDisabled ? disabledColor : style['backgroundColor'],
      borderColor: isDisabled ? disabledColor : style['borderColor'],
    );

    if (isMobile()) {
      cardButton = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 50),
        child: cardButton,
      );
    }
    return cardButton;
  }
}
