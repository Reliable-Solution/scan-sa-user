import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    required this.hintText,
    this.hintStyle,
    this.style,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.suffixIcon,
    this.bottomPadding,
    this.textInputAction,
    this.inputFormatters,
    this.borderColor,
    this.prefixIcon,
    this.focusNode,
  });
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? bottomPadding;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 14.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        maxLength: maxLength,
        enabled: enabled,
        readOnly: readOnly,
        textInputAction: textInputAction ?? TextInputAction.next,
        style: style ?? context.style.s16w700,
        inputFormatters: const [],
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Get.find<GlobalController>().isDark
              ? context.color.whiteLight
              : null,
          counter: SizedBox.fromSize(),
          hintText: hintText,
          hintStyle:
              hintStyle ??
              context.style.s16w700.copyWith(
                color: borderColor ?? context.color.ff9c9c9c,
              ),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? context.color.borderColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? context.color.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: borderColor ?? context.color.borderColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
