



import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:uni_credit/shared_widgets/form_components/form_controller_utility.dart';
import 'package:uni_credit/shared_widgets/form_components/linked_text_input.dart';
import 'package:uni_credit/shared_widgets/form_components/password_input.dart';
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';
import 'package:uni_credit/shared_widgets/form_components/validations.dart';
import 'package:uni_credit/shared_widgets/item_sizes.dart';
import 'package:uni_credit/shared_widgets/responsive/media_queries.dart';
import 'package:uni_credit/shared_widgets/widgets/title.dart';

class RegisterBody extends StatelessWidget {
  final FormValidationController formController;
  const RegisterBody({super.key, required  this.formController});


  onRegister(BuildContext context) {

    context.router.pop(

    );
  }

  @override
  Widget build(BuildContext context) {

    FormValidatorUtility formUtility = FormValidatorUtility(formController,
    );

    formUtility.inputLineItemPadding = EdgeInsets.only(top: 12 );
    return Container(
      width: 300,
      child: formUtility.InputLine(
        crossAxis: CrossAxisAlignment.center,
        deviceAxis: DeviceOption(
          defaultResult: Axis.vertical,
        ),
        children: [
          TitleWidget(title: 'Registro'),

         LinkedTextInput(formUtility: formUtility,
             validator: Validations.minimalLetters(6) ,
             name: 'matricula', displayName: 'Matricula'),
          LinkedTextInput(formUtility: formUtility,
             validator: Validations.email ,
             name: 'email', displayName: 'Email'),

          PasswordInput(formUtility: formUtility,
          usingInputForRegistration: true,),
          LinkedTextInput(formUtility: formUtility, name: 'name', displayName: 'Nome',),
          LinkedTextInput(formUtility: formUtility, name: 'lastName', displayName: 'Sobrenome',

          inputStyle: LinkedTextInputStyle(
            inputAction: TextInputAction.done,
          ),),

          CardButtonV1(title: CardTextContent(content: 'Criar conta'),
          buttonSize: ItemSize.unlimited,
            onPress: ()=>onRegister(context),
            cardIntention: CardIntention.action,
            pressEnabled: formUtility.formController
            .getValidationState(),
            height: CardDimension(
              itemSize: ItemSize.normal
            ),
          )

        ],
      ),
    );
  }
}
