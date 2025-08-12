import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown({
    super.key,
    required this.itemList,
    required this.selectedItem,
    this.child,
    this.onChanged,
    this.hint,
    this.hintStyle,
    this.backColor,
    this.style,
    this.margin,
  });
  final List<String> itemList;
  final String? selectedItem;
  final String? hint;
  final Color? backColor;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final EdgeInsets? margin;
  final Widget Function(String item)? child;
  final Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: context.color.borderColor, width: 2),
        borderRadius: BorderRadius.circular(10),
        color:
            backColor ??
            (Get.find<GlobalController>().isDark
                ? context.color.whiteLight
                : context.color.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.sizeOf(context).width - (2 * AppSizes.appPadding),
          ),
          hint: Text(
            hint ?? 'Select Item',
            style: hintStyle ?? context.style.s18w700,
          ),
          style:
              style ??
              context.style.s18w700.copyWith(color: context.color.ff455A64),
          items: itemList
              .map(
                (String item) => DropdownMenuItem<String>(
                  value: item,
                  child:
                      child?.call(item) ??
                      Text(
                        item,
                        style: context.style.s18w700.copyWith(
                          color: context.color.ff455A64,
                        ),
                      ),
                ),
              )
              .toList(),
          value: selectedItem,
          onChanged: onChanged,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 26),
          ),
        ),
      ),
    );
  }
}
