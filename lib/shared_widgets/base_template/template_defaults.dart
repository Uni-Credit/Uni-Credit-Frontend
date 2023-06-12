import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/cupertino.dart';

import '../../atech/atech_framework_settings.dart';
import '../responsive/media_queries.dart';

abstract class AppbarDefinition {
  double get height;
  bool get restrictWidth;
}

class TemplateAppbar extends AppbarDefinition {
  Widget? content;
  Widget? background;
  final bool shouldRestrictWidth;

  @override
  double get height => 60;

  @override
  bool get restrictWidth => shouldRestrictWidth;

  TemplateAppbar(
      {this.shouldRestrictWidth = false, this.content, this.background});
}

abstract class NavbarDefinition {
  double get height;
}

class TemplateNavbar extends NavbarDefinition {
  Widget? content;

  @override
  double height = 45;
  double padding = 16;
}

class TemplateBackground {
  Widget? content;
}

class OverlayConfiguration {
  BuildContext context;
  bool useOverlay;
  OverlayConfiguration({required this.context, required this.useOverlay});
}

class TemplateBody {
  double get horizontalPadding =>
      returnAppropriateGlobal(defaultResult: 12, mobile: 8);
  double topPadding = 72;

  Function(OverlayConfiguration)? overlay;
}

class TemplateDefaults {
  TemplateNavbar navbar = TemplateNavbar();
  TemplateAppbar appbar = TemplateAppbar();
  TemplateBackground background = TemplateBackground();
  TemplateBody body = TemplateBody();

  ScrollerBehaviour scrollerBehaviour = ScrollerBehaviour.whole;

  bool usesDrawer = false;
  Widget? drawer;
}
