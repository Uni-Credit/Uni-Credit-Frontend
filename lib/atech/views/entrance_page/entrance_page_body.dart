import 'package:framework/atech/views/entrance_page/entrance_page.dart';
import 'package:framework/atech/views/entrance_page/entrance_view.dart';
import 'package:framework/atech/views/entrance_page/layout/entrance_layout.dart';
import 'package:framework/atech/views/entrance_page/entrance_actions/icons_entrance_actions.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/views/entrance_page/widgets/page_logo.dart';

import '../../../shared_widgets/graphical_item/on_error_image.dart';

class EntrancePageBody extends StatefulWidget {
  final EntrancePageConstruction construction;
  const EntrancePageBody({Key? key, required this.construction})
      : super(key: key);

  @override
  State<EntrancePageBody> createState() => _EntrancePageBodyState();
}

class _EntrancePageBodyState extends State<EntrancePageBody> {
  @override
  Widget build(BuildContext context) {
    return EntranceView(
        construction: EntranceConstruction(
            presentationElementLayout:
                widget.construction.presentationElementLayout ??
                    PageLogo(
                        image: widget.construction.image ??
                            Image.asset(
                              "lib/assets/images/logo.png",
                              errorBuilder: (context, error, stackTrace) {
                                return OnErrorImage();
                              },
                            )),
            actionElementLayout: IconsEntranceActions(
              actionsController: widget.construction.actionsController,
            )));
  }
}
