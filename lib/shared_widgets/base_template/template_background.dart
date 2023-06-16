import 'package:uni_credit/shared_widgets/base_template/size_restriction_definition/restricted_element_definition.dart';
import 'package:uni_credit/shared_widgets/base_template/template_defaults.dart';
import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/cupertino.dart';

import '../../framework.dart';


class BackgroundLayoutDefinition {
  final NavbarConfiguration navbarConfiguration;
  final Widget? background;
  final RestrictedElementDefinition elementDefinition;

  BackgroundLayoutDefinition(
      {this.background,
      required this.navbarConfiguration,
      required this.elementDefinition});
}

class TemplateBackgroundLayout extends StatelessWidget {
  final BackgroundLayoutDefinition definition;
  const TemplateBackgroundLayout({
    Key? key,
    required this.definition,
  }) : super(key: key);

  bool useNavigator() {
    return (definition.navbarConfiguration.useNavigatorAsBackground);
  }

  static double commonNavbarAppendingPadding = 16;

  @override
  Widget build(BuildContext context) {
    // #TODO REMEMBER => RENAME AND REORGANIZE BACKGROUND RELATED ITEMS

    NavbarConfiguration navbarConfiguration = definition.navbarConfiguration;

    return Container(
      //color: Colors.blue,
      child: Stack(
        children: [
          TemplateTopNavbarContent(
            navbarConfiguration: NavbarConfiguration(
              padding: navbarConfiguration.useDefaultPadding
                  ? EdgeInsets.only(
                      top: Framework.templateDefaults.navbar.padding)
                  : EdgeInsets.zero,
              appending: navbarConfiguration.appending,
              useNavigatorAsBackground: useNavigator() &&
                  (navbarConfiguration.useNavigatorAsBackground),
              navbar: navbarConfiguration.navbar ??
                  (navbarConfiguration.usesDefaultNavbar
                      ? Framework.templateDefaults.navbar.content
                      : null),
            ),
            height: navbarConfiguration.height,
          ),
          Visibility(
            visible: navbarConfiguration.useTwoNavbars,
            child: Padding(
              padding: EdgeInsets.only(top: navbarConfiguration.height),
              child: TemplateTopNavbarContent(
                navbarConfiguration: NavbarConfiguration(
                  padding: navbarConfiguration.useDefaultPadding
                      ? EdgeInsets.only(
                          //    top: defaultNavbarPadding
                          )
                      : EdgeInsets.zero,
                  appending: navbarConfiguration.appending,
                  useNavigatorAsBackground: useNavigator() &&
                      (navbarConfiguration.useNavigatorAsBackground),
                  usesDefaultNavbar: true,
                  // navbar: parent.navbarConfiguration.navbar ?? Container(),
                ),
                height: navbarConfiguration.height,
              ),
            ),
          ),
          definition.background ??
              Framework.templateDefaults.background.content ??
              Container(),
          navbarConfiguration.background ?? Container(),
          (navbarConfiguration.restrictedSizeNavBar ??
                      navbarConfiguration.restrictedSizeNavBar) ==
                  null
              ? Container()
              : Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: definition.elementDefinition.restrictedWidth,
                    height: navbarConfiguration.navbarHeight ??
                        navbarConfiguration.height,
                    child: (navbarConfiguration.restrictedSizeNavBar ??
                        navbarConfiguration.restrictedSizeNavBar),
                  ),
                )
        ],
      ),
    );
  }
}
