


import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:uni_credit/routes/router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PageInfo(LoginRoute.name), initial: true)
  ];
}