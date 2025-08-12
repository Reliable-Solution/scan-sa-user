import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:shimmer/shimmer.dart';

class CacheImageNetwork extends StatelessWidget {
  const CacheImageNetwork(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.radius,
    this.isCircular = false,
    this.boxFit,
    this.color,
  });
  final String imageUrl;
  final double? width;
  final Color? color;
  final double? height;
  final double? radius;
  final bool isCircular;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: ColoredBox(
        color: color ?? context.color.grey,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: boxFit,
          height: height ?? (isCircular ? radius : null),
          width: width ?? (isCircular ? radius : null),
          progressIndicatorBuilder: (context, url, progress) =>
              Shimmer.fromColors(
                baseColor: context.color.grey,
                highlightColor: context.color.grey,
                child: isCircular
                    ? CircleAvatar(radius: radius)
                    : SizedBox(height: height ?? 50, width: width ?? 50),
              ),
          errorWidget: (context, url, error) => isCircular
              ? CircleAvatar(
                  radius: radius,
                  backgroundColor: context.color.grey,
                  child: const Icon(Icons.image_not_supported_rounded),
                )
              : SizedBox(
                  height: height ?? 50,
                  width: width ?? 50,
                  child: const Icon(Icons.image_not_supported_rounded),
                ),
        ),
      ),
    );
  }
}
