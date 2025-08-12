import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerExt on Widget {
  Widget shimmer(BuildContext context, {bool isLoad = true}) => isLoad
      ? Shimmer.fromColors(
          baseColor: Get.find<GlobalController>().isDark
              ? context.color.grey
              : context.color.borderColor,
          highlightColor: Get.find<GlobalController>().isDark
              ? context.color.whiteLight
              : context.color.fff5f5f5,
          child: this,
        )
      : this;
}
