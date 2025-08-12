import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.borderRadius = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    required this.isError,
  });
  final String text;
  final bool isError;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: isError ? context.color.errorColor : context.color.primary,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: padding,
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isError
                      ? CupertinoIcons.multiply_circle_fill
                      : Icons.check_circle,
                  color: isError ? Colors.white : const Color(0xff039D55),
                  size: 20,
                ),
                Flexible(
                  child: Text(
                    text,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.style.s14w600.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
