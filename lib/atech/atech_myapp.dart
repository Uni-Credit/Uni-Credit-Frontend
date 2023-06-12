import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import '../generated/l10n.dart';
import 'language/language_controller.dart';

class ATechMyApp extends StatefulWidget {
  final Widget child;
  const ATechMyApp({Key? key, required this.child}) : super(key: key);

  @override
  State<ATechMyApp> createState() => _ATechMyAppState();

  static LanguageController languageController = LanguageController();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_ATechMyAppState>();
    state?.setLocale(newLocale);
  }

  static supportedLocales() {
    return AppLocalizationDelegate().supportedLocales;
  }

  static List<LocalizationsDelegate<dynamic>> getLocalizationDelegates() {
    return [
      AppLocalizationDelegate(),
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      LocaleNamesLocalizationsDelegate(),
    ];
  }

  static Locale? resolveLocale(
      Locale? locale, Iterable<Locale> supportedLocales) {
    return supportedLocales.firstWhere(
        (element) => element.languageCode == locale?.languageCode,
        orElse: () => supportedLocales.first);
  }
}

class _ATechMyAppState extends State<ATechMyApp> {
  void setLocale(Locale locale) async {
    await S.load(locale);

    setState(() {
      ATechMyApp.languageController
          .changeLanguage(context, locale.languageCode);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ATechMyApp.languageController.addListener(() {
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }

      (context as Element).visitChildren(rebuild);
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() async {
    LanguageController.getLocale().then((locale) {
      setState(() {
        ATechMyApp.languageController.setLocale(locale.languageCode);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    S.load(ATechMyApp.languageController.locale);

    return widget.child;
  }
}
