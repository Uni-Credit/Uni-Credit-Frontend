



import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/models/enums/http_method.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/requests/app_dio.dart';
import 'package:framework/requests/backend_request.dart';
import 'package:framework/requests/caller/response_request_caller.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/linked_text_input.dart';
import 'package:framework/shared_widgets/form_components/password_input.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';
import 'package:framework/shared_widgets/form_components/validations.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:framework/shared_widgets/popups/response_popup.dart';
import 'package:framework/shared_widgets/responsive/media_queries.dart';
import 'package:framework/shared_widgets/widgets/title.dart';
import 'package:uni_credit/views/login_page/data/models/user_credentials.dart';

class RegisterBody extends StatelessWidget {
  final FormValidationController formController;
  const RegisterBody({super.key, required  this.formController});


  onRegister(BuildContext context) async {

    ResponsePopup(
      requestProcess: RequestProcess(
          ResponseRequestCaller(
              BackendRequest.call(dio: AppRequestDio(
                url: "http://localhost:3000",
              ), onPath: "/auth/register",
                withMethod: HttpMethod.post,
                extractArgData: (arg){
                  return arg;
                }
              )
          ).call(argument: formController.readFields()),

          StatusResolver.requestStatusResolver
      ),
      onClickAfterClose: () {
       // if(response.success) {
          context.router.pop();
        //}
      }
    ).showDialogWithWidget(context);

  }

  @override
  Widget build(BuildContext context) {

    FormValidatorUtility formUtility = FormValidatorUtility(
      formController,
        defaultValidator: Validations.requiredField,
    );

    formUtility.inputLineItemPadding = EdgeInsets.only(top: 12 );
    return Container(
      width: 300,
      child: formUtility.InputLine(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          inputKey: "password",
          usingInputForRegistration: true,),
          LinkedTextInput(formUtility: formUtility, name: 'name', displayName: 'Nome',),
          LinkedTextInput(formUtility: formUtility, name: 'lastName', displayName: 'Sobrenome',

          inputStyle: LinkedTextInputStyle(
            inputAction: TextInputAction.done,
          ),),

          CardButtonV1(
            title: CardTextContent(content: 'Criar conta',
            padding: EdgeInsets.symmetric(
              horizontal: 32
            )),
          buttonSize: ItemSize.minimal,

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
