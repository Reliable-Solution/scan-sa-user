import 'package:flutter/cupertino.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  const ProfileButtonWidget({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.isButtonActive,
    this.color,
    this.iconImage,
  });
  final IconData? icon;
  final String title;
  final bool? isButtonActive;
  final Function onTap;
  final Color? color;
  final String? iconImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeSmall,
          vertical: isButtonActive != null
              ? Dimensions.paddingSizeExtraSmall
              : Dimensions.paddingSizeDefault,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          border: Border.all(color: context.color.secondary, width: 0.1),
          boxShadow: [
            BoxShadow(
              color: context.color.secondary.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            iconImage != null
                ? Image.asset(iconImage!, height: 18, width: 25)
                : Icon(
                    icon,
                    size: 25,
                    color:
                        color ?? Theme.of(context).textTheme.bodyMedium!.color,
                  ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Text(title, style: robotoRegular)),
            isButtonActive != null
                ? Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: isButtonActive!,
                      activeTrackColor: context.color.secondary,
                      onChanged: (bool? value) => onTap(),
                      inactiveTrackColor:
                          context.color.secondary.withValues(alpha: 0.5),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
