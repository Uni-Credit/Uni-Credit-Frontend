

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/models/extensions/for_widget.dart';
import 'package:uni_credit/models/session.dart';
import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:uni_credit/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:uni_credit/shared_widgets/item_sizes.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/login_page/widgets/introduction_view.dart';

import 'login_page_body.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callForIntroduction();
  }

  callForIntroduction({bool alwaysShow=false}) async {

    bool firstSession = await Session.firstSession.getValue();

    if(alwaysShow || firstSession) {
      IntroductionView(onDone: () {
        Session.firstSession.setValue(false);
        context.router.pop();
      },).showDialogInNextFrame(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      useDefaultPadding: true,

      appbarConfig: AppbarConfiguration(
        ignorePadding: true,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(

              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                  onTap: (){

                    callForIntroduction(alwaysShow: true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.help_outline,
                      color: ThemeColors.getConstrastToBackground()
                    ),
                  ))

            ),
          ],
        )
      ),
        body:   LoginPageBody());
  }
}
