import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:form_components/form_components/form_controller_utility.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_bloc.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_events.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_states.dart';

class LoginConfirmButton extends StatelessWidget {
  final FormValidatorUtility formUtility;


  const LoginConfirmButton({Key? key, required this.formUtility,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {

        LoginFormBloc bloc = context.read<LoginFormBloc>();

        bool canPressButton =
            [LoginFailure, LoginLoading].contains(state.runtimeType)
                == false
                &&
                bloc.loginIsValid();

        return CardButtonV1(
            title: CardTextContent(content: Text(
              'Login', style: TextStyle(
                color:
                formUtility.formController.getValidationState(
                    emptyDefault: false) ?
                Colors.white : Colors.black
            ),
            )),
            // leadingIcon: CardIconData(icon: Icon(Icons.person)),
            width: CardDimension(itemSize: ItemSize.minimal),
            cardIntention: CardIntention.action,
            //trailingIcon: CardIconData(),
            pressEnabled: canPressButton,
            onPress: (){
              context.read<LoginFormBloc>().add(LoginFormSubmitted());
            },
            backgroundColor: ThemeColors.getActionColor()
        );
      },
    )  ;
  }
}


