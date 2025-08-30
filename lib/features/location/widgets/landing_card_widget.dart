import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';

class LandingCardWidget extends StatelessWidget {
  const LandingCardWidget({
    super.key,
    required this.icon,
    required this.title,
    this.imageBaseUrlType,
  });
  final String icon;
  final String? imageBaseUrlType;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        color: context.color.secondary.withValues(alpha: 0.05),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            image: icon,
            height: 45,
            width: 45,
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Text(
            title,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
