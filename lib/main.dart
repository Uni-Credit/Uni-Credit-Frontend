
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_credit/models/singletons/user_session/user_session.dart';
import 'package:uni_credit/routes/router.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/setup_framework.dart';
import 'package:uni_credit/theme/theme_colors.dart';

void main() async {
  setupFramework();
  runApp(MyApp());

  GetIt.I.registerSingleton(
      getUserSession()
  );
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() =>
      _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter(
    /*  userTypeGuard: UserTypeGuard(), sessionTokenGuard: SessionTokenGuard()*/);

  @override
  Widget build(BuildContext context) {
    //debugPrint("Running my app build");

    return
      MaterialApp.router(
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
      //scaffoldBackgroundColor:  Color(0xff0B0E0C),
      brightness: Brightness.dark,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xff13199C),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:
          ThemeColors.getSpecialColor(), width: 1.5)
        )
      ),
      textTheme: TextTheme(
        //labelMedium: TextStyle(color: ThemeColors.getConstrastToBackground())
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.dark(
          background: ThemeColors.getActionColor(),
          surface: Colors.white
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
          iconColor: MaterialStateColor.resolveWith((states) {
            //return Colors.black87;
            return ThemeColors.getDeactivatedColor();
          })
      )),
       primaryColor: ThemeColors.getFirstOverlayBackground(),
      colorScheme: ColorScheme.dark(
        background:  Color(0xff0B0E0C)
      ),
      //colorScheme: ColorScheme(),
      scrollbarTheme: ScrollbarThemeData(
          trackColor:
          MaterialStateColor.resolveWith((states) => Color(0xffcccccc)),
          thumbVisibility: MaterialStateProperty.all(true),
          )
    );
  }
}
