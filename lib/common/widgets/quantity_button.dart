import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton({
    super.key,
    required this.isIncrement,
    required this.onTap,
    this.fromSheet = false,
    this.showRemoveIcon = false,
    this.color,
  });
  final bool isIncrement;
  final Function? onTap;
  final bool fromSheet;
  final bool showRemoveIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        height: fromSheet ? 30 : 22,
        width: fromSheet ? 30 : 22,
        margin:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: showRemoveIcon
                ? Theme.of(context).colorScheme.error
                : isIncrement
                    ? context.color.secondary
                    : Theme.of(context).disabledColor,
          ),
          color: showRemoveIcon
              ? Theme.of(context).cardColor
              : isIncrement
                  ? color ?? context.color.secondary
                  : Theme.of(context).disabledColor.withValues(alpha: 0.2),
        ),
        alignment: Alignment.center,
        child: Icon(
          showRemoveIcon
              ? Icons.delete_outline_outlined
              : isIncrement
                  ? Icons.add
                  : Icons.remove,
          size: 15,
          color: showRemoveIcon
              ? Theme.of(context).colorScheme.error
              : isIncrement
                  ? Theme.of(context).cardColor
                  : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
