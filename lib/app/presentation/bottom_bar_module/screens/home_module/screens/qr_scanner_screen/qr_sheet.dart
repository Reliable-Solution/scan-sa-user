import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showQrSheet(BuildContext context, Function() onClose) {
  Get.bottomSheet(QrSheet(onClose: onClose), isScrollControlled: true);
}

class QrSheet extends StatelessWidget {
  const QrSheet({super.key, required this.onClose});
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 50, bottom: 120.h),
          // margin: const EdgeInsets.only(top: 75),
          decoration: BoxDecoration(
            color: context.color.whiteLight,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [context.color.white, const Color(0xFFFDF5DA)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * .6,
                    child: Text(
                      'SCAN QR AT RESTAURANT TO ORDER !',
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: context.color.ff6A2100,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   width: 200,
              //   child: AppButton(
              //     isBottomPad: true,
              //     buttonType: ButtonType.yellow,
              //     btnColor: context.color.secondary,
              //     label: 'Got it!',
              //     textStyle: context.style.s18w700.copyWith(
              //       fontWeight: FontWeight.w900,
              //       color: context.color.ff6A2100,
              //     ),
              //     onPressed: () {},
              //   ),
              // ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgAssets(AppIcons.qrInitIc, height: 275.h),
              ),
            ),
            SizedBox(
              width: 200.w,
              child: AppButton(
                isBottomPad: true,
                buttonType: ButtonType.yellow,
                btnColor: context.color.secondary,
                label: 'Got it!',
                textStyle: context.style.s18w700.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.color.ff6A2100,
                ),
                onPressed: () {
                  onClose();
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
