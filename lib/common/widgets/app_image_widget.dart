import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class SvgAssets extends SvgPicture {
  SvgAssets(
    super.assetName, {
    super.key,
    super.width,
    super.height,
    Color? color,
    BoxFit? fit,
  }) : super.asset(
          fit: fit ?? BoxFit.contain,
          colorFilter:
              color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        );
}
