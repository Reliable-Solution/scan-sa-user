import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class StoreFilterButtonWidget extends StatelessWidget {
  const StoreFilterButtonWidget({
    super.key,
    this.isSelected,
    this.onTap,
    required this.buttonText,
  });

  final bool? isSelected;
  final void Function()? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35,
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: isSelected == true
              ? context.color.secondary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected == true
                ? context.color.secondary
                : Theme.of(context).disabledColor.withValues(alpha: 0.7),
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              fontWeight:
                  isSelected == true ? FontWeight.w600 : FontWeight.w400,
              color: isSelected == true
                  ? context.color.white
                  : Theme.of(context).disabledColor,
            ),
          ),
        ),
      ),
    );
  }
}
