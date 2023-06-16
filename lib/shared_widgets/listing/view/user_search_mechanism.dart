import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:uni_credit/shared_widgets/form_components/form_controller_utility.dart';
import 'package:uni_credit/shared_widgets/form_components/linked_text_input.dart';
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';

class UserSearchMechanism extends StatelessWidget {
  final Function onSearch;
  UserSearchMechanism({Key? key, required this.onSearch}) : super(key: key);

  final FormValidationController formController = FormValidationController();
  @override
  Widget build(BuildContext context) {
    FormValidatorUtility formUtility = FormValidatorUtility(formController);
    return LinkedTextInput(
      formUtility: formUtility,
      name: "search",
      displayName: "Pesquisar por Nome",
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconActionCardButton(
          content: 'Pesquisar',
          icon: Icon(
            Icons.search,
            color: Colors.white70,
          ),
          forceMobile: true,
          onPress: () {
            onSearch(formController.readFields());
          },
        ),
      ),
    );
  }
}
