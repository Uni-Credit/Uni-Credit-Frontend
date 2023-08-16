


import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:uni_credit/routes/router.gr.dart';

// Run " flutter packages pub run build_runner build " to update routes

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PageInfo(Register.name)),
    AutoRoute(page: PageInfo(Login.name), initial: true ),
    AutoRoute(page: PageInfo(Dashboard.name)),
    AutoRoute(page: PageInfo(Transaction.name), ),
  AutoRoute(page: PageInfo(Configuration.name), ),
  AutoRoute(page: PageInfo(Historic.name), ),

  ];
}