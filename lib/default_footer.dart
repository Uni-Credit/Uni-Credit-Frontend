

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/models/extensions/for_build_context.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/dashboard_page/atualizations_widget.dart';
import 'package:uni_credit/views/dashboard_page/widgets/dashboard_buttons.dart';

class DefaultFooter extends StatefulWidget {
  const DefaultFooter({super.key});

  @override
  State<DefaultFooter> createState() => _DefaultFooterState();
}

class _DefaultFooterState extends State<DefaultFooter> {
  double multiplier= 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [  Padding(
          padding: const EdgeInsets.only(bottom: 8*0 ),
          child: CardButtonV1(title: CardTextContent(content:
          Icon(multiplier == 1 ? Icons.keyboard_arrow_down :
          Icons.keyboard_arrow_up)),
            backgroundColor: ThemeColors.getDark(),
            onPress: (){
              setState(() {
                if(multiplier == 0) {
                  multiplier =1;
                  return;
                }
                multiplier = 0;
              });
            },
            width: CardDimension(size: context.width),
          ),
        ),
          Visibility(
            visible: multiplier != 0,
            child: Container(
              color: ThemeColors.getDark(),
              width: context.width,
              height: 400*multiplier,
              child: AtualizationsWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: DashboardButtons(),
          ),

        ],
      ),
    );
  }
}
