import 'package:flutter/material.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CommonTabBar extends StatelessWidget {
  const CommonTabBar({
    super.key,
    required this.tabList,
    required this.selectedValue,
    required this.onTap,
    this.padding,
  });
  final List<String> tabList;
  final String selectedValue;
  final Function(String value) onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabList
              .map(
                (e) =>
                    textBtn(context, title: e, isSelected: e == selectedValue),
              )
              .toList(),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(color: context.color.grey),
            Row(
              children: tabList
                  .map(
                    (e) => Expanded(
                      child: AnimatedContainer(
                        duration: Durations.short4,
                        height: e == selectedValue ? 5 : 0,
                        color: e == selectedValue
                            ? context.color.secondary
                            : Colors.transparent,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget textBtn(
    BuildContext context, {
    required String title,
    bool isSelected = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(title),
        child: Container(
          color: Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.style.s18w700.copyWith(
              color: isSelected
                  ? context.color.secondary
                  : context.color.primary,
            ),
          ),
        ),
      ),
    );
  }
}
