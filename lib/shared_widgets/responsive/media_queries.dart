import 'package:flutter/cupertino.dart';

// #todo : make a class for SizeWidthControl
// currently the getAppropriate functions dont update if the screen size changes,
// leading to unnecessary bugs that are weirdly solved by using
// MediaQuery.of(context).size.width (that automatically listens for changes for you)

enum DeviceType { desktop, mobile, tablet }

const double MIN_WIDTH = 360;
const double MAX_WIDTH = 1024;

const double MIN_HEIGHT = 640;

class DeviceOption<T> {
  T? desktop;
  T? mobile;
  T? defaultResult;
  T? tablet;

  DeviceOption({this.desktop, this.mobile, this.defaultResult, this.tablet});

  getValue() {
    return returnAppropriateGlobal(
        defaultResult: defaultResult,
        desktop: desktop,
        mobile: mobile,
        tablet: tablet);
  }
}

DeviceType screenModelBasedOnWidth({context, double? width}) {
  width ??= context != null
      ? MediaQuery.of(context).size.width
      : MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

  if (width >= 1024) {
    return DeviceType.desktop;
  }

  if (width >= 768) {
    return DeviceType.tablet;
  }

  return DeviceType.mobile;
}

T returnAppropriateGlobal<T>(
    {T? desktop, T? mobile, T? defaultResult, T? tablet}) {
  return returnFromModel(screenModelBasedOnWidth(),
      desktop: desktop,
      mobile: mobile,
      tablet: tablet,
      defaultResult: defaultResult);
}

T returnAppropriate<T>(BuildContext context,
    {T? desktop, T? mobile, T? tablet, T? defaultResult}) {
  DeviceType model = screenModelBasedOnWidth(context: context);
  return returnFromModel(model,
      desktop: desktop,
      mobile: mobile,
      tablet: tablet,
      defaultResult: defaultResult);
}

T returnFromModel<T>(DeviceType model,
    {T? desktop, T? mobile, T? tablet, T? defaultResult}) {
  defaultResult ??= (mobile ?? (tablet ?? desktop)) as T;

  switch (model) {
    case DeviceType.mobile:
      return mobile ?? defaultResult!;
    case DeviceType.desktop:
      return desktop ?? defaultResult!;
    case DeviceType.tablet:
      return tablet ?? defaultResult!;
  }
}

bool isMobile() {
  return screenModelBasedOnWidth() == DeviceType.mobile;
}

bool isDesktop() {
  return screenModelBasedOnWidth() == DeviceType.desktop;
}
