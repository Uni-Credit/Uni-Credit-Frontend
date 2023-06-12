import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:framework/atech/requests/login_request.dart';
import 'package:framework/atech/requests/patient_requests.dart';
import 'package:framework/models/extensions/for_build_context.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/base_template/go_back_button.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:framework/shared_widgets/popups/confirmation_popup.dart';
import 'package:framework/shared_widgets/popups/informative_popup.dart';
import 'package:framework/shared_widgets/popups/response_popup.dart';
import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

import '../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../shared_widgets/form_components/form_widget_listener.dart';
import '../../models/language_read.dart';
import '../../requests/backend_response.dart';
import '../login/login_form.dart';

class ForgotPasswordPageBody extends StatefulWidget {
  ForgotPasswordPageBody({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPageBody> createState() => _ForgotPasswordPageBodyState();
}

class _ForgotPasswordPageBodyState extends State<ForgotPasswordPageBody> {
  final FormValidationController formController = FormValidationController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formController.onValidationChange((isValid) {
      setState(() {});
    });
  }

  onConfirm() {
    RequestProcess<BackendResponse> process = RequestProcess(
        LoginRequests.confirmForgetPassword(
            argument: FreeFormArgumentCaller(args: {})),
        StatusResolver.requestStatusResolver);

    ResponsePopup(
      requestProcess: process,
      successBuilder: (context, body) {
        return InformativePopup(
          title: 'Um email foi enviado para confirmar a troca de senha!',
          onClickAfterClosed: () {
            context.router.pop();
          },
        );
      },
    ).showDialogWithWidget(context);
  }

  @override
  Widget build(BuildContext context) {
    FormValidatorUtility formUtility = FormValidatorUtility(formController,
        defaultValidateMode: AutovalidateMode.onUserInteraction);

    CardButtonV1SizeResolver sizeResolver =
        CardButtonV1SizeResolver(ItemSize.normal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: sizeResolver.resolveWidth(
            context,
          ),
          child: Column(
            children: [
              Container(
                  height: sizeResolver.resolveHeight(context),
                  child: EmailInput(formUtility: formUtility)),
              Container(
                height: sizeResolver.resolveHeight(context),
              ),
              CardButtonV1(
                title: CardTextContent(content: LR.of(context).confirmAction),
                buttonSize: ItemSize.normal,
                onPress: onConfirm,
                active: formUtility.formController.getValidationState(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
