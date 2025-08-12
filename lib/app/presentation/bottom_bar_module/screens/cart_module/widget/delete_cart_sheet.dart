import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showDeleteSheet({required bool isFromHome}) {
  Get.bottomSheet(
    DeleteCartSheet(isFromHome: isFromHome),
    backgroundColor: Get.context!.color.whiteLight,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
  );
}

class DeleteCartSheet extends StatelessWidget {
  const DeleteCartSheet({super.key, required this.isFromHome});
  final bool isFromHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        AppSizes.appPadding,
      ).copyWith(bottom: MediaQuery.paddingOf(context).bottom),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.l10n.confirmDeleteCart, style: context.style.s24w700),
          Text(
            context.l10n.deleteCartDescription,
            style: context.style.s18w700.copyWith(
              color: context.color.ff6c6c6c,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AppButton(
              label: context.l10n.deleteCart,
              txtColor: Colors.white,
              buttonType: ButtonType.red,
              onPressed: () {
                Get.back();
                Get.find<CartController>().clearCartOnline().then(
                  (value) => isFromHome ? null : Get.back(),
                );
              },
              btnColor: context.color.redColor,
            ),
          ),
          AppButton(
            label: context.l10n.keepCart,
            buttonType: ButtonType.white,
            onPressed: Get.back,
            btnColor: context.color.grey,
            txtColor: context.color.primary,
          ),
        ],
      ),
    );
  }
}
