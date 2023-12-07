// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/cupertino.dart' as _i10;
import 'package:uni_credit/views/announcements_page/announcement_page.dart'
    as _i1;
import 'package:uni_credit/views/configuration_page/configuration_page.dart'
    as _i2;
import 'package:uni_credit/views/dashboard_page/dashboard_page.dart' as _i3;
import 'package:uni_credit/views/historic_page/historic_page.dart' as _i4;
import 'package:uni_credit/views/login_page/login_page.dart' as _i5;
import 'package:uni_credit/views/make_transaction_page/complete_transaction_page.dart'
    as _i6;
import 'package:uni_credit/views/make_transaction_page/make_transaction_page.dart'
    as _i7;
import 'package:uni_credit/views/register_page/register_page.dart' as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AnnouncementRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AnnouncementPage(),
      );
    },
    Configuration.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ConfigurationPage(),
      );
    },
    Dashboard.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardPage(),
      );
    },
    Historic.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HistoricPage(),
      );
    },
    LoginUser.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    CompleteTransactionRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CompleteTransactionPage(),
      );
    },
    Transaction.name: (routeData) {
      final args = routeData.argsAs<TransactionArgs>();
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.MakeTransactionPage(
          key: args.key,
          construction: args.construction,
        ),
      );
    },
    Register.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AnnouncementPage]
class AnnouncementRoute extends _i9.PageRouteInfo<void> {
  const AnnouncementRoute({List<_i9.PageRouteInfo>? children})
      : super(
          AnnouncementRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnnouncementRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ConfigurationPage]
class Configuration extends _i9.PageRouteInfo<void> {
  const Configuration({List<_i9.PageRouteInfo>? children})
      : super(
          Configuration.name,
          initialChildren: children,
        );

  static const String name = 'Configuration';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DashboardPage]
class Dashboard extends _i9.PageRouteInfo<void> {
  const Dashboard({List<_i9.PageRouteInfo>? children})
      : super(
          Dashboard.name,
          initialChildren: children,
        );

  static const String name = 'Dashboard';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HistoricPage]
class Historic extends _i9.PageRouteInfo<void> {
  const Historic({List<_i9.PageRouteInfo>? children})
      : super(
          Historic.name,
          initialChildren: children,
        );

  static const String name = 'Historic';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginUser extends _i9.PageRouteInfo<void> {
  const LoginUser({List<_i9.PageRouteInfo>? children})
      : super(
          LoginUser.name,
          initialChildren: children,
        );

  static const String name = 'LoginUser';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CompleteTransactionPage]
class CompleteTransactionRoute extends _i9.PageRouteInfo<void> {
  const CompleteTransactionRoute({List<_i9.PageRouteInfo>? children})
      : super(
          CompleteTransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompleteTransactionRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MakeTransactionPage]
class Transaction extends _i9.PageRouteInfo<TransactionArgs> {
  Transaction({
    _i10.Key? key,
    required _i7.MakeTransactionConstruction construction,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          Transaction.name,
          args: TransactionArgs(
            key: key,
            construction: construction,
          ),
          initialChildren: children,
        );

  static const String name = 'Transaction';

  static const _i9.PageInfo<TransactionArgs> page =
      _i9.PageInfo<TransactionArgs>(name);
}

class TransactionArgs {
  const TransactionArgs({
    this.key,
    required this.construction,
  });

  final _i10.Key? key;

  final _i7.MakeTransactionConstruction construction;

  @override
  String toString() {
    return 'TransactionArgs{key: $key, construction: $construction}';
  }
}

/// generated route for
/// [_i8.RegisterPage]
class Register extends _i9.PageRouteInfo<void> {
  const Register({List<_i9.PageRouteInfo>? children})
      : super(
          Register.name,
          initialChildren: children,
        );

  static const String name = 'Register';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
