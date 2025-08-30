import 'package:flutter/widgets.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';

class AppTextStyle {
  AppTextStyle(this.context);
  final BuildContext context;

  TextStyle get s12w700 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: context.color.secondary,
      );

  TextStyle get s14w600 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: context.color.secondary,
      );

  TextStyle get s14w700 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: context.color.secondary,
      );

  TextStyle get s16w300 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: context.color.secondary,
      );

  TextStyle get s16w500 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: context.color.secondary,
      );

  TextStyle get s16w700 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: context.color.secondary,
      );

  TextStyle get s18w700 => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: context.color.darkTextGrey,
      );

  TextStyle get s20w900 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        color: context.color.secondary,
      );

  TextStyle get s22w700 => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: context.color.secondary,
      );

  TextStyle get s24w700 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: context.color.secondary,
      );

  TextStyle get s24w900 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: context.color.secondary,
      );
  TextStyle get s28w900 => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: context.color.secondary,
      );

  TextStyle get s30w700 => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: context.color.secondary,
      );
}
