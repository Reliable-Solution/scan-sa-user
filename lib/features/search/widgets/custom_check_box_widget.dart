import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  const CustomCheckBoxWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onClick,
  });
  final String title;
  final bool value;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick as void Function()?,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (bool? isActive) => onClick(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: context.color.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              side: BorderSide.none,
            ),
          ),
          Text(title, style: robotoRegular),
        ],
      ),
    );
  }
}
