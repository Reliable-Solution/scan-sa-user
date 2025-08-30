import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:shimmer/shimmer.dart';

extension ShimmerExt on Widget {
  Widget shimmer(BuildContext context, {bool isLoad = true}) => isLoad
      ? Shimmer.fromColors(
          baseColor: context.color.grey,
          highlightColor: context.color.blueColor,
          child: this,
        )
      : this;
}
