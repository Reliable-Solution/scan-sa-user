import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/common_sheet.dart';
import 'package:scan_sa_user/app/widgets/selection_circle.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showPaymentSelectionSheet() {
  Get.bottomSheet(const PaymentSelectionSheet());
}

class PaymentSelectionSheet extends StatelessWidget {
  const PaymentSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 17),
          child: Text(
            context.l10n.choosePayment,
            style: context.style.s24w700.copyWith(color: context.color.primary),
          ),
        ),
        methodWidget(context, title: 'Cash', icon: AppIcons.cash),
        Divider(height: 0, color: context.color.grey),
        methodWidget(context, title: 'Wallet', icon: AppIcons.wallet),
        Divider(height: 0, color: context.color.grey),
        methodWidget(context, title: 'Elm', icon: AppIcons.elm),
        Divider(height: 0, color: context.color.grey),
        methodWidget(context, title: 'Clickpay', icon: AppIcons.cashFree),
      ],
    );
  }

  Widget methodWidget(
    BuildContext context, {
    required String title,
    required String icon,
  }) {
    return Obx(() {
      final checkoutController = Get.find<CheckoutController>();
      return GestureDetector(
        onTap: () => checkoutController.paymentMethod(title),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Row(
            spacing: 10,
            children: [
              SvgAssets(icon),
              Text(
                title,
                style: context.style.s18w700.copyWith(
                  color: context.color.ff6c6c6c,
                ),
              ),
              const Spacer(),
              SelectionCircle(
                isSelected: checkoutController.selectedMethod.value == title,
              ),
            ],
          ),
        ),
      );
    });
  }
}
