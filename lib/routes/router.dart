


import 'package:authentication/routes/router.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/views/authentication/forgot_password_page_meta.dart';
import 'package:uni_credit/views/authentication/login_page_meta.dart';
import 'package:uni_credit/views/authentication/register_page_meta.dart';

// Run " flutter packages pub run build_runner build " to update routes

/*
class UniCreditAuthenticationAppRouter extends AuthenticationAppRouter {
  UniCreditAuthenticationAppRouter({
    super.forgotPasswordPageMeta = const UniCreditForgotPasswordPageMeta(),
    super.loginPageMeta = const UniCreditLoginPageMeta(),
    super.registerPageMeta = const UniCreditRegisterMeta(),
    super.startAtLogin=true
  });


}*/



@AutoRouterConfig(replaceInRouteName: 'Page,Route',
    modules: []

)
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [

    AutoRoute(page: PageInfo(Register.name)),
 AutoRoute(page: PageInfo(LoginUser.name), initial: true ),
    AutoRoute(page: PageInfo(AboutRoute.name), ),

/*  ...UniCreditAuthenticationAppRouter().routes,*/
    AutoRoute(page: PageInfo(Dashboard.name)),
    AutoRoute(page: PageInfo(Transaction.name), ),
  AutoRoute(page: PageInfo(Configuration.name), ),
  AutoRoute(page: PageInfo(Historic.name), ),
  AutoRoute(page: PageInfo(CompleteTransactionRoute.name), ),

  ];
}