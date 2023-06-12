import 'package:framework/atech/views/entrance_page/presentation_element_layout.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/graphical_item/interactive_document/interactive_document.dart';
import 'package:framework/shared_widgets/graphical_item/interactive_document/responsive_image.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageLogo extends PresentationElementLayout {
  final Image? image;
  const PageLogo({
    Key? key,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double logoSize = 180;

    String logoPath = 'lib/assets/images/logo.png';

    return Container(
      height: logoSize,
      child: image ?? Image.asset(logoPath),
    );
    return ResponsiveImage(
      imageSize: logoSize / 2,
      imageSizeLoadingConfiguration:
          image == null ? null : ImageSizeLoadingConfiguration(image: image),
      imageFileName: logoPath,
      imageBuilder: (ImageSizeLoadingConfiguration loadingConfiguration) {
        return SizedBox(
          width: loadingConfiguration.imageSizeWidth,
          height: loadingConfiguration.imageSizeWidth,
          child: loadingConfiguration.getImage(),
        );
      },
      imageRatioUse: ImageRatioRelativeTarget.width,
    );
  }
}
