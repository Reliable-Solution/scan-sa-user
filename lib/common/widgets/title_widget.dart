import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/language/controllers/language_controller.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.onTap, this.image});
  final String title;
  final Function? onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final bool ltr = Get.find<LocalizationController>().isLtr;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: robotoBold.copyWith(
                fontSize: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.fontSizeLarge
                    : Dimensions.fontSizeLarge,
              ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            image != null
                ? Image.asset(image!, height: 20, width: 20)
                : const SizedBox(),
          ],
        ),
        (onTap != null)
            ? InkWell(
                onTap: onTap as void Function()?,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(ltr ? 10 : 0, 5, ltr ? 0 : 10, 5),
                  child: Text(
                    'see_all'.tr,
                    style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: context.color.secondary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
