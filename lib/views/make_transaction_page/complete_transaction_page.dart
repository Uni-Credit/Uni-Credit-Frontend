




import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/widgets/title.dart';
import 'package:uni_credit/theme/theme_colors.dart';


@RoutePage()
class CompleteTransactionPage extends StatelessWidget {
  const CompleteTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(body: Column(
      children: [
        TitleWidget(title: 'Copie PIX para pagar!'),
        CardButtonV1(
            backgroundColor:
            ThemeColors.getFirstOverlayBackground(),
            height: CardDimension(size: 200),
            title: CardTextContent(
          content: 'XYZ123456'
        ))
      ],
    ));
  }
}
