import 'dart:math';
import 'package:uni_credit/framework.dart';
import 'package:uni_credit/models/extensions/for_build_context.dart';
import 'package:uni_credit/shared_widgets/base_template/size_restriction_definition/restricted_element_definition.dart';
import 'package:uni_credit/shared_widgets/base_template/template_background.dart';
import 'package:uni_credit/shared_widgets/base_template/template_body.dart';
import 'package:uni_credit/shared_widgets/base_template/template_defaults.dart';
import 'package:uni_credit/shared_widgets/base_template/size_restriction_definition/template_restricted_element.dart';
import 'package:flutter/material.dart';
import '../responsive/media_queries.dart';
import '../listing/multi_child_scroll_view.dart';

// #TODO REMEMBER: ENUM FOR SCROLL BEHAVIOUR
// #TODO REMEMBER: ENUM FOR BACKGROUND ORGANIZATION
// #TODO REMEMBER: BRING TEMPLATE ITEM CLASS FROM SMU PROJECT FILES
// #TODO REMEMBER: ENUM FOR NAVIGATION BEHAVIOUR

class NavbarConfiguration extends NavbarDefinition {
  Widget? restrictedSizeNavBar;
  Widget? background;
  Widget? appending;
  Widget? navbar;

  double? navbarHeight;
  EdgeInsets? padding;
  bool useDefaultPadding;
  bool useNavigatorAsBackground;
  bool usesDefaultNavbar;
  bool useDefaultBackgroundPadding;
  bool useTwoNavbars; //

  MainAxisAlignment mainAlignment;

  bool ignoreNavbarPadding;
  bool canIgnoreNavbarHeight;

  NavbarConfiguration(
      {this.navbar,
      this.navbarHeight,
      this.restrictedSizeNavBar,
      this.background,
      this.appending,
      this.padding,
      this.usesDefaultNavbar = true,
      this.ignoreNavbarPadding = true,
      this.canIgnoreNavbarHeight = true,
      this.mainAlignment = MainAxisAlignment.start,
      this.useDefaultPadding = true,
      this.useTwoNavbars = false,
      this.useDefaultBackgroundPadding = true,
      this.useNavigatorAsBackground = true});

  @override
  double get height => navbarHeight ?? Framework.templateDefaults.navbar.height;
}

class AppbarConfiguration extends AppbarDefinition {
  final Widget? content;
  final Widget? background;
  final MainAxisAlignment? mainAlignment;

  final bool ignorePadding;
  final bool useDefault;
  double? navbarHeight;
  final bool? shouldRestrictWidth;

  AppbarConfiguration(
      {this.content,
      height,
      this.useDefault = true,
      this.background,
      this.mainAlignment,
      this.ignorePadding = false,
      this.shouldRestrictWidth}) {
    navbarHeight = height;
  }

  bool hasAppBar() {
    return useDefault || (background != null && content != null);
  }

  @override
  double get height => navbarHeight ?? Framework.templateDefaults.appbar.height;

  @override
  bool get restrictWidth =>
      shouldRestrictWidth ?? Framework.templateDefaults.appbar.restrictWidth;
}

enum ScrollerBehaviour { whole, onlyBody, none }

class BodyConfiguration {}

class TemplateScaffold extends StatelessWidget {
  final Widget body;
  final Widget? background;
  final Color? backgroundColor;
  late NavbarConfiguration navbarConfiguration;
  late AppbarConfiguration appbarConfiguration;

  final ScrollerBehaviour? scrollerBehaviour;
  final bool showRouteNavigator;
  final bool useDefaultPadding;
  final bool nullifyHeight;
  final bool isUsingScaffold;
  final bool useOverlay;

  final Widget Function(BuildContext context, double realWidth, Widget body)?
      bodyParent;
  final Widget? backgroundBeforeNavigation;
  final Widget? floatingAction;

  final bool? isUsingDrawer;

  TemplateScaffold(
      {Key? key,
      required this.body,
      this.backgroundBeforeNavigation,
      this.isUsingDrawer,
      this.useDefaultPadding = true,
      this.nullifyHeight = false,
      this.bodyParent,
      this.showRouteNavigator = true,
      this.floatingAction,
      this.background,
      NavbarConfiguration? navbarConfig,
      AppbarConfiguration? appbarConfig,
      this.isUsingScaffold = true,
      this.scrollerBehaviour,
      this.backgroundColor,
      this.useOverlay = true})
      : super(key: key) {
    navbarConfiguration = navbarConfig ?? NavbarConfiguration();
    appbarConfiguration = appbarConfig ?? AppbarConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    if (!isUsingScaffold) {
      return body;
    }

    double realWidth = max(
      MediaQuery.of(context).size.width,
      MIN_WIDTH,
    );
    double restrictedWidth = /*max(*/ min(realWidth, MAX_WIDTH); //, 767);

    RestrictedElementDefinition elementDefinition = RestrictedElementDefinition(
        realWidth: realWidth,
        restrictedWidth: restrictedWidth,
        preferredHeight: appbarConfiguration.height);

    /*
    if (screenModelBasedOnWidth() == DeviceType.mobile &&
        !devMode &&
        usesMobileBlock) {
      return InProgress(templateScaffold: this);
    }*/

    Widget bodyWidget = _TemplateBody(
        navbarConfiguration: navbarConfiguration,
        elementDefinition: elementDefinition,
        background: background,
        appbarConfiguration: appbarConfiguration,
        scrollerBehaviour: scrollerBehaviour,
        body: body,
        useDefaultPadding: useDefaultPadding,
        bodyParent: bodyParent);

    return Scaffold(
      floatingActionButton: floatingAction,
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          bodyWidget,
          Framework.templateDefaults.body.overlay == null
              ? Container()
              : Framework.templateDefaults.body.overlay!(OverlayConfiguration(
                  context: context, useOverlay: useOverlay))
        ],
      ),
      appBar: appbarConfiguration.hasAppBar()
          ? elementDefinition.getElement(
              width: Framework.templateDefaults.appbar.restrictWidth
                  ? null
                  : MediaQuery.of(context).size.width,
              content: appbarConfiguration.content ??
                  (appbarConfiguration.useDefault
                      ? Framework.templateDefaults.appbar.content
                      : null),
              background: appbarConfiguration.background ??
                  (appbarConfiguration.useDefault
                      ? Framework.templateDefaults.appbar.background
                      : null))
          : null,
      drawer: usesDrawer ? Framework.templateDefaults.drawer : null,
    );
  }

  bool get usesDrawer => isUsingDrawer ?? Framework.templateDefaults.usesDrawer;
}

class _TemplateBody extends StatelessWidget {
  const _TemplateBody({
    super.key,
    required this.navbarConfiguration,
    required this.elementDefinition,
    required this.background,
    required this.appbarConfiguration,
    required this.scrollerBehaviour,
    required this.body,
    required this.useDefaultPadding,
    required this.bodyParent,
  });

  final NavbarConfiguration navbarConfiguration;
  final RestrictedElementDefinition elementDefinition;
  final Widget? background;
  final AppbarConfiguration appbarConfiguration;
  final ScrollerBehaviour? scrollerBehaviour;
  final Widget body;
  final bool useDefaultPadding;
  final Widget Function(BuildContext context, double realWidth, Widget body)?
      bodyParent;

  @override
  Widget build(BuildContext context) {
    return TemplateBodyLayout(
      definition: BodyLayoutDefinition(
        background: TemplateBackgroundLayout(
          definition: BackgroundLayoutDefinition(
              navbarConfiguration: navbarConfiguration,
              elementDefinition: elementDefinition,
              background: background),
        ),
        appbarConfiguration: appbarConfiguration,
        navbarConfiguration: navbarConfiguration,
        scrollBehaviour:
            scrollerBehaviour ?? Framework.templateDefaults.scrollerBehaviour,
        elementDefinition: elementDefinition,
        body: body,
        useDefaultPadding: useDefaultPadding,
        bodyParent: bodyParent,
      ),
    );
  }
}

class TemplateTopNavbarContent extends StatelessWidget {
  final double height;
  final NavbarConfiguration navbarConfiguration;

  const TemplateTopNavbarContent({
    Key? key,
    required this.height,
    required this.navbarConfiguration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: navbarConfiguration.padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: navbarConfiguration.mainAlignment,
            children: [
              navbarConfiguration.navbar ?? Container(),
              navbarConfiguration.appending ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
