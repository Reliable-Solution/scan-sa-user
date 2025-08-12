import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/common_sheet.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showCallSheet() {
  Get.bottomSheet(const CallSheet());
}

class CallSheet extends StatelessWidget {
  const CallSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            'Trying to reach the restaurant?',
            style: context.style.s20w900.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        AppTextField(
          hintText: '+971 2 123 4567',
          hintStyle: context.style.s16w700.copyWith(
            color: context.color.ff6c6c6c,
          ),
          enabled: false,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgAssets(AppIcons.callLightIc),
          ),
        ),
      ],
    );
  }
}
