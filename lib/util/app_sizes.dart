import 'package:flutter/widgets.dart';

class AppSizes {
  AppSizes._();

  static double appPadding = 24;
  static const double topPad = 10;
}

class AppPadding {
  static EdgeInsets bottomPad(BuildContext context) => EdgeInsets.only(
        bottom: (MediaQuery.paddingOf(context).bottom / 1.5) + 10,
        top: 10,
        right: AppSizes.appPadding,
        left: AppSizes.appPadding,
      );
  static EdgeInsets commonSubPad = EdgeInsets.symmetric(
    horizontal: AppSizes.appPadding,
    vertical: 20,
  );
}
