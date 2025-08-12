import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CircularBtn extends StatelessWidget {
  const CircularBtn({
    super.key,
    this.color,
    this.radius,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });
  final Color? color;
  final Color? iconColor;
  final String icon;
  final double? radius;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius ?? 20,
        backgroundColor: color ?? context.color.white,
        child: SvgAssets(
          icon,
          color: iconColor ?? context.color.primary,
          width: 24,
        ),
      ),
    );
  }
}
