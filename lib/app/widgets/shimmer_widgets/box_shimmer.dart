import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';

class BoxShimmer extends StatelessWidget {
  const BoxShimmer({super.key, this.height, this.width, this.radius});
  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8,
      width: width ?? 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radius ?? 3),
      ),
    ).shimmer(context);
  }
}
