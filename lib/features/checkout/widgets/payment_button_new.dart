import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';

class PaymentButtonNew extends StatelessWidget {
  const PaymentButtonNew({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final String icon;
  final String title;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            border: Border.all(
              color: isSelected
                  ? context.color.secondary
                  : Theme.of(context).disabledColor.withValues(alpha: 0.5),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeSmall,
            vertical: Dimensions.paddingSizeLarge,
          ),
          child: Row(
            children: [
              Image.asset(
                icon,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                ),
              ),
              isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.color.secondary,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
