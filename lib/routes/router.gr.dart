// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:uni_credit/views/configuration_page/configuration_page.dart'
    as _i1;
import 'package:uni_credit/views/dashboard_page/dashboard_page.dart' as _i2;
import 'package:uni_credit/views/historic_page/historic_page.dart' as _i3;
import 'package:uni_credit/views/login_page/login_page.dart' as _i4;
import 'package:uni_credit/views/make_transaction_page/make_transaction_page.dart'
    as _i5;
import 'package:uni_credit/views/register_page/register_page.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    Configuration.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ConfigurationPage(),
      );
    },
    Dashboard.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    Historic.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HistoricPage(),
      );
    },
    Login.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    Transaction.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MakeTransactionPage(),
      );
    },
    Register.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ConfigurationPage]
class Configuration extends _i7.PageRouteInfo<void> {
  const Configuration({List<_i7.PageRouteInfo>? children})
      : super(
          Configuration.name,
          initialChildren: children,
        );

  static const String name = 'Configuration';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DashboardPage]
class Dashboard extends _i7.PageRouteInfo<void> {
  const Dashboard({List<_i7.PageRouteInfo>? children})
      : super(
          Dashboard.name,
          initialChildren: children,
        );

  static const String name = 'Dashboard';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HistoricPage]
class Historic extends _i7.PageRouteInfo<void> {
  const Historic({List<_i7.PageRouteInfo>? children})
      : super(
          Historic.name,
          initialChildren: children,
        );

  static const String name = 'Historic';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class Login extends _i7.PageRouteInfo<void> {
  const Login({List<_i7.PageRouteInfo>? children})
      : super(
          Login.name,
          initialChildren: children,
        );

  static const String name = 'Login';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MakeTransactionPage]
class Transaction extends _i7.PageRouteInfo<void> {
  const Transaction({List<_i7.PageRouteInfo>? children})
      : super(
          Transaction.name,
          initialChildren: children,
        );

  static const String name = 'Transaction';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class Register extends _i7.PageRouteInfo<void> {
  const Register({List<_i7.PageRouteInfo>? children})
      : super(
          Register.name,
          initialChildren: children,
        );

  static const String name = 'Register';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
