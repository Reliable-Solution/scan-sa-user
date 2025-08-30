import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class BottomNavItemWidget extends StatelessWidget {
  const BottomNavItemWidget({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
    this.widget,
  });
  final String selectedIcon;
  final String unSelectedIcon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Dimensions.paddingSizeExtraSmall,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                SvgAssets(
                  isSelected ? selectedIcon : unSelectedIcon,
                  height: 22,
                  width: 22,
                  color: isSelected
                      ? context.color.primary
                      : context.color.darkTextGrey,
                ),
                if (widget != null) widget!,
              ],
            ),
            Text(
              title,
              style: robotoRegular.copyWith(
                color: isSelected
                    ? context.color.primary
                    : context.color.darkTextGrey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
