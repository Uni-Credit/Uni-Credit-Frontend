import 'package:flutter/cupertino.dart';
import 'package:framework/atech/models/language_read.dart';

import '../../../shared_widgets/base_template/widgets/card_button_v1.dart';
import '../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../shared_widgets/item_sizes.dart';
import 'layouts/login_view_layout.dart';

class LoginConfirmButton extends LoginConfirmationLayout {
  final FormValidatorUtility formUtility;
  final Function() onLogin;
  const LoginConfirmButton(
      {Key? key, required this.formUtility, required this.onLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
      title: CardTextContent(content: LR.of(context).confirmLogin),
      buttonSize: ItemSize.normal,
      cardIntention: CardIntention.action,
      width: CardDimension(nulify: true),
      pressEnabled:
          formUtility.formController.getValidationState(emptyDefault: false),
      onPress: onLogin,
    );
  }
}
