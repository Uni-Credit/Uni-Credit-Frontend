// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:uni_credit/views/configuration_page/configuration_page.dart'
    as _i4;
import 'package:uni_credit/views/dashboard_page/dashboard_page.dart' as _i1;
import 'package:uni_credit/views/historic_page/historic_page.dart' as _i5;
import 'package:uni_credit/views/login_page/login_page.dart' as _i2;
import 'package:uni_credit/views/make_transaction_page/make_transaction_page.dart'
    as _i3;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    Dashboard.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DashboardPage(),
      );
    },
    Login.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    Transaction.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MakeTransactionPage(),
      );
    },
    Configuration.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ConfigurationPage(),
      );
    },
    Historic.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HistoricPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DashboardPage]
class Dashboard extends _i6.PageRouteInfo<void> {
  const Dashboard({List<_i6.PageRouteInfo>? children})
      : super(
          Dashboard.name,
          initialChildren: children,
        );

  static const String name = 'Dashboard';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginPage]
class Login extends _i6.PageRouteInfo<void> {
  const Login({List<_i6.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MakeTransactionPage]
class Transaction extends _i6.PageRouteInfo<void> {
  const Transaction({List<_i6.PageRouteInfo>? children})
      : super(
          Transaction.name,
          initialChildren: children,
        );

  static const String name = 'Transaction';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ConfigurationPage]
class Configuration extends _i6.PageRouteInfo<void> {
  const Configuration({List<_i6.PageRouteInfo>? children})
      : super(
          Configuration.name,
          initialChildren: children,
        );

  static const String name = 'Configuration';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HistoricPage]
class Historic extends _i6.PageRouteInfo<void> {
  const Historic({List<_i6.PageRouteInfo>? children})
      : super(
          Historic.name,
          initialChildren: children,
        );

  static const String name = 'Historic';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
