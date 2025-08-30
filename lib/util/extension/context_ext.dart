import 'package:flutter/material.dart';
import 'package:scan_sa_user/theme/app_color.dart';
import 'package:scan_sa_user/theme/app_text_style.dart';

extension ContextExt on BuildContext {
  /// to get colors
  AppColor get color => AppColor(this);

  /// to get sizes
  Size get sizes => MediaQuery.sizeOf(this);

  /// to get text styles
  AppTextStyle get style => AppTextStyle(this);

  /// to get top bottom default padding
  EdgeInsets get padding => MediaQuery.paddingOf(this);
}
