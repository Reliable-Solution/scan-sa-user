import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/common/widgets/custom_text_field.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/widgets/common_sheet.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

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
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Trying to reach the restaurant?',
            style: context.style.s20w900.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        CustomTextField(
          isEnabled: false,
          controller: TextEditingController(text: '+971 2 123 4567'),
          labelText: 'Phone number',
          suffixChild: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgAssets(Images.callIc),
          ),
        ),
        // AppTextField(
        //   hintStyle: context.style.s16w700.copyWith(
        //     color: context.color.ff6c6c6c,
        //   ),
        //   enabled: false,
        // ),
      ],
    );
  }
}
