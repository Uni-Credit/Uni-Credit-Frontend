




import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:form_components/form_components/form_controller_utility.dart';

import 'package:form_components/form_components/input_spacer.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';

import '../../../routes/router.gr.dart';
import 'login_confirm_button.dart';

class UnicreditLoginActionButtons extends StatelessWidget {

  final FormValidatorUtility formUtility;
  const UnicreditLoginActionButtons({super.key,
    required this.formUtility});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        LoginConfirmButton(formUtility: formUtility, ),

        InputSpacer(),
        CardButtonV1(
          width: CardDimension(itemSize: ItemSize.minimal),
          title: CardTextContent(content: 'Registrar'),
          onPress: (){
            context.router.push(
                Register()
            );
          },
          /*
              leadingIcon: CardIconData(
                icon: Icon(
                    Icons.person_add
                )
              ),
              trailingIcon: CardIconData(),*/

        ),
      ],
    );
  }
}
