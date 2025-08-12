import 'package:flutter/material.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CartBtn extends StatelessWidget {
  const CartBtn({
    super.key,
    required this.cartValue,
    required this.isAddBtn,
    required this.onTap,
    required this.onTapAdd,
    this.height,
    this.color,
    this.textColor,
  });
  final int cartValue;
  final bool isAddBtn;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Function(bool isRemove) onTap;
  final Function() onTapAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isAddBtn ? onTapAdd() : null,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.color.borderColor),
          color: color ?? context.color.white,
          boxShadow: [
            BoxShadow(
              color: context.color.primary.withValues(alpha: .25),
              blurRadius: 10,
              spreadRadius: -1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: isAddBtn ? 30 : 0),
        child: isAddBtn
            ? Text(
                'ADD',
                style: context.style.s16w700.copyWith(
                  color: textColor ?? context.color.greenColor,
                ),
              )
            : Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  removeAddBtn(
                    context,
                    icon: Icons.remove_rounded,
                    isRemove: true,
                  ),
                  Text(
                    cartValue.toString(),
                    style: context.style.s16w700.copyWith(
                      color: textColor ?? context.color.greenColor,
                    ),
                  ),
                  removeAddBtn(context, icon: Icons.add_rounded),
                ],
              ),
      ),
    );
  }

  Widget removeAddBtn(
    BuildContext context, {
    required IconData icon,
    bool isRemove = false,
  }) {
    return GestureDetector(
      onTap: () => onTap(isRemove),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.transparent,
        child: Icon(
          icon,
          color: textColor ?? context.color.greenColor,
          size: 18,
        ),
      ),
    );
  }
}
