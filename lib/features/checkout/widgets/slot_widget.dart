import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SlotWidget extends StatelessWidget {
  const SlotWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraSmall,
            horizontal: Dimensions.paddingSizeExtraSmall,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? context.color.secondary
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                spreadRadius: 0.5,
                blurRadius: 0.5,
              ),
            ],
          ),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(
              color: isSelected
                  ? Theme.of(context).cardColor
                  : Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: Dimensions.fontSizeExtraSmall,
            ),
          ),
        ),
      ),
    );
  }
}
