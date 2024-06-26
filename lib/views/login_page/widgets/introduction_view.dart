

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:uni_credit/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:uni_credit/shared_widgets/item_sizes.dart';
import 'package:uni_credit/shared_widgets/popups/template_popup.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/login_page/widgets/app_logo.dart';

class IntroductionView extends StatelessWidget {
  final Function() onDone;
  const IntroductionView({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {

    List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Bem vindo ao UniCredit!",
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Text("Sua Carteira Digital Estudantil!"),
        ],
      ),
      image: AppLogo(itemSize: ItemSize.small,),
    ),
      PageViewModel(
      title: "Carteira Estudantil",
      bodyWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Text("Pague antecipadamente!"),
        ],
      ),
        image:  Icon(Icons.money_outlined),
    ),PageViewModel(
      title: "Poupe seu tempo!",
      bodyWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Text("Vamos começar?"),
          Text('Faça seu login com o Sistema da FURG!')
        ],
      ),
        image:  Icon(Icons.access_alarms_rounded),
    ),
    ];

    return IntroductionScreen(
      pages: listPagesViewModel,
      globalBackgroundColor: ThemeColors.getBackground(),
      next: CardButtonV1( title: CardTextContent(content:  Icon( Icons.arrow_right_alt,
      color: Colors.white,
      )),),
      back: Container(
        color: ThemeColors.getBackground(),
      ),
      done: CardButtonV1(title: CardTextContent(content: 'Continuar'),),
      onDone: onDone,
    );
  }
}
