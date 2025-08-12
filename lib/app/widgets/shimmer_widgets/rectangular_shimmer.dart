import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class RectangularShimmer extends StatelessWidget {
  const RectangularShimmer({super.key, this.height, this.width, this.radius});
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.grey,
        borderRadius: BorderRadius.circular(radius ?? 4),
      ),
      height: height ?? 20,
      width: width ?? 50,
    ).shimmer(context);
  }
}
