import 'package:flutter/material.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';

class CircularShimmer extends StatelessWidget {
  const CircularShimmer({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: size).shimmer(context);
  }
}
