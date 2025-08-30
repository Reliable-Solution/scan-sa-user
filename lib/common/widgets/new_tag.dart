import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class NewTag extends StatelessWidget {
  const NewTag({super.key, this.top = 5, this.left = 3, this.right});
  final double? top, left, right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          color: context.color.secondary,
        ),
        child: Text(
          'new'.tr,
          style: robotoMedium.copyWith(
            color: Theme.of(context).cardColor,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
      ),
    );
  }
}
