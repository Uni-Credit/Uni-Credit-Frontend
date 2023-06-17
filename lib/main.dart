
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/routes/router.gr.dart';

void main() async {
  runApp(MyAppHealthProfessional());
}


class MyAppHealthProfessional extends StatefulWidget {
  MyAppHealthProfessional({super.key});

  @override
  State<MyAppHealthProfessional> createState() =>
      _MyAppHealthProfessionalState();
}

class _MyAppHealthProfessionalState extends State<MyAppHealthProfessional> {
  final _appRouter = AppRouter(
    /*  userTypeGuard: UserTypeGuard(), sessionTokenGuard: SessionTokenGuard()*/);

  @override
  Widget build(BuildContext context) {
    //debugPrint("Running my app build");

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        //  locale: MyApp.languageController.locale,
        routerDelegate: routerDelegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ) ;
  }

  AutoRouterDelegate routerDelegate() {
    return _appRouter.delegate(
      /* navigatorObservers: () => [
              NavigationFluxObserver(),
            ]*/
    );
  }

  ThemeData appTheme() {
    return ThemeData(
      textTheme: TextTheme(
        //labelMedium: TextStyle(color: ThemeColors.getConstrastToBackground())
      ),
      scrollbarTheme: ScrollbarThemeData(
          trackColor:
          MaterialStateColor.resolveWith((states) => Color(0xffcccccc)),
          thumbVisibility: MaterialStateProperty.all(true),
          )
    );
  }
}
