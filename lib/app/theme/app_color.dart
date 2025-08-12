import 'package:flutter/material.dart';

class AppColor {
  AppColor(this.context);
  final BuildContext context;

  Color get primary => Theme.of(context).colorScheme.primary;
  Color get white => Theme.of(context).colorScheme.onPrimary;
  Color get secondary => Theme.of(context).colorScheme.secondary;
  Color get whiteLight => Theme.of(context).colorScheme.onSecondary;
  Color get errorColor => Theme.of(context).colorScheme.error;
  Color get redColor => Theme.of(context).colorScheme.onError;
  Color get lightText => Theme.of(context).colorScheme.onTertiary;
  Color get blueColor => Theme.of(context).colorScheme.tertiary;
  Color get grey => Theme.of(context).colorScheme.onTertiaryContainer;
  Color get darkTextGrey => Theme.of(context).colorScheme.onTertiaryFixed;
  Color get borderColor => Theme.of(context).colorScheme.onTertiaryFixedVariant;
  Color get ff9c9c9c => Theme.of(context).colorScheme.onSecondaryFixed;
  Color get fff5f5f5 => Theme.of(context).colorScheme.secondaryFixed;
  Color get ff455A64 => Theme.of(context).colorScheme.tertiaryContainer;
  Color get ff6c6c6c => Theme.of(context).colorScheme.secondaryFixedDim;
  Color get greenColor => Theme.of(context).colorScheme.tertiaryFixed;
  Color get ff828282 => Theme.of(context).colorScheme.surfaceTint;
  Color get ff6A2100 => Theme.of(context).colorScheme.scrim;
  Color get ff093624 => Theme.of(context).colorScheme.tertiaryFixedDim;
  Color get ff65C8A0 => Theme.of(context).colorScheme.surfaceContainerHigh;
}
