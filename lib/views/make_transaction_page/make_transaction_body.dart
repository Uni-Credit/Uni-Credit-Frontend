


import 'package:auto_route/auto_route.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_components/form_components/form_controller_utility.dart';

import 'package:form_components/form_components/validation_form_controller.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:form_components/form_components/form_controller_utility.dart';
import 'package:form_components/form_components/linked_text_input.dart';
import 'package:form_components/form_components/validation_form_controller.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class MakeTransactionBody extends StatelessWidget {
  const MakeTransactionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(

          height: 100,
          width: context.width*0.8,
          child: Row(
            children: [
              Expanded(
                child: LinkedTextInput(formUtility: FormValidatorUtility(
                  FormValidationController()
                ), name: 'quantity',
                  displayName: 'Valor a inserir',

                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true, fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.black87
                  ),
                  hintText: 'Valor a inserir'
                ),

    textStyle: TextStyle(
      color: Colors.black
    ),

                  inputStyle: LinkedTextInputStyle(

                  ),
                ),
              ),

              Container(
                width: 30,
                alignment: Alignment.center,
                height: 54,
                color: ThemeColors.getVibrantGreen(),
                child: Text('\$'),
              )
            ],
          ),
        ),
        CardButtonV1(
          onPress: (){
            context.router.push(
              CompleteTransactionRoute()
            );
          },
            title: CardTextContent(content: 'Confirmar'))
      ],
    );
  }
}
