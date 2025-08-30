import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class SortingTextButton extends StatelessWidget {
  const SortingTextButton({
    super.key,
    required this.title,
    this.onTap,
    this.isSelected = false,
  });
  final String title;
  final void Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: robotoMedium.copyWith(
          fontSize: Dimensions.fontSizeSmall,
          color: isSelected
              ? context.color.secondary
              : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
