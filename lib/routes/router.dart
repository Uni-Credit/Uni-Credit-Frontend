

import 'package:auto_route/annotations.dart';
import 'package:uni_credit/test_views/main_page/main_page.dart';
import 'package:uni_credit/views/login_page/login_page.dart';

// Run " flutter packages pub run build_runner build " to update routes

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
      AutoRoute(page: MainPage, path: '/'),
    AutoRoute(page: LoginPage)

  ],
)
class $AppRouter {}

