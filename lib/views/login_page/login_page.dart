
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:framework/shared_widgets/widgets/highlighted_text.dart';
import 'package:uni_credit/routes/router.gr.dart';

import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_bloc.dart';
import 'data/interactors/api_login_form_interactor.dart';
import 'login_page_body.dart';

@RoutePage(name: 'loginUser')
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

  callForIntroduction({bool alwaysShow = false}) async {


    /*bool firstSession = await Session.firstSession.getValue();

    if(alwaysShow || firstSession) {
      IntroductionView(onDone: () {
        Session.firstSession.setValue(false);
        context.router.pop();
      },).showDialogInNextFrame(context);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      useDefaultPadding: false,
      navbarConfig: NavbarConfiguration.empty(),
      appbarConfig: AppbarConfiguration(
        //ignorePadding: true,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(

                  padding: const EdgeInsets.only(right: 12.0),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: () {
                          callForIntroduction(alwaysShow: true);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.help_outline,
                              color: ThemeColors.getConstrastToBackground()
                          ),
                        )),
                  )

              ),
            ],
          )
      ),
      body: BlocProvider(

          create: (context) => LoginFormBloc(
            loginFormInteractor: APILoginFormInteractor(),

          ),
          child: LoginPageBody()),

      /**/
      footer: [
        Row(

          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HighlightedText(
                  highlightTextStyle: HighlightTextStyle.subtleLink,
                  onPressed: () {
                    context.router.push(AboutRoute());
                  }, display: 'Sobre'),
            ),
          ],
        )
      ],
    );
  }
}
