import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/styles.dart';

class WebScreenTitleWidget extends StatelessWidget {
  const WebScreenTitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)
        ? Container(
            height: 64,
            color: context.color.secondary.withValues(alpha: 0.10),
            child: Center(child: Text(title, style: robotoMedium)),
          )
        : const SizedBox();
  }
}
