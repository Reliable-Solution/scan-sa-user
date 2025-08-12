import 'package:flutter/material.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class SelectionCircle extends StatelessWidget {
  const SelectionCircle({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Durations.short3,
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? context.color.greenColor
              : context.color.borderColor,
          width: isSelected ? 10 : 2,
        ),
        shape: BoxShape.circle,
        color: isSelected ? Colors.white : context.color.fff5f5f5,
      ),
    );
  }
}
