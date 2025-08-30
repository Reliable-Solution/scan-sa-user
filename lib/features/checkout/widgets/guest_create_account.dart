import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/custom_text_field.dart';
import 'package:scan_sa_user/features/checkout/controllers/checkout_controller.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/validate_check.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/styles.dart';

class GuestCreateAccount extends StatelessWidget {
  const GuestCreateAccount({
    super.key,
    required this.guestPasswordController,
    required this.guestConfirmPasswordController,
    required this.guestPasswordNode,
    required this.guestConfirmPasswordNode,
    this.fromParcel = false,
  });
  final TextEditingController guestPasswordController;
  final TextEditingController guestConfirmPasswordController;
  final FocusNode guestPasswordNode;
  final FocusNode guestConfirmPasswordNode;
  final bool fromParcel;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);

    return GetBuilder<CheckoutController>(
      builder: (checkoutController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            boxShadow: fromParcel
                ? [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Theme.of(context)
                          .primaryColor
                          .withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeLarge,
            vertical: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: checkoutController.isCreateAccount,
                      onChanged: (bool? value) =>
                          checkoutController.toggleCreateAccount(),
                      activeColor: context.color.secondary,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Text(
                    'create_account_with_existing_info'.tr,
                    style: robotoMedium,
                  ),
                ],
              ),
              SizedBox(
                height: checkoutController.isCreateAccount
                    ? Dimensions.paddingSizeLarge
                    : 0,
              ),
              Visibility(
                visible: checkoutController.isCreateAccount,
                child: isDesktop
                    ? Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              labelText: 'password'.tr,
                              titleText: '8_character'.tr,
                              controller: guestPasswordController,
                              focusNode: guestPasswordNode,
                              nextFocus: guestConfirmPasswordNode,
                              inputType: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock,
                              isPassword: true,
                              required: true,
                              validator: (value) =>
                                  ValidateCheck.validateEmptyText(value, null),
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeDefault),
                          Expanded(
                            child: CustomTextField(
                              labelText: 'confirm_password'.tr,
                              titleText: '8_character'.tr,
                              controller: guestConfirmPasswordController,
                              focusNode: guestConfirmPasswordNode,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.visiblePassword,
                              prefixIcon: Icons.lock,
                              isPassword: true,
                              required: true,
                              validator: (value) =>
                                  ValidateCheck.validateEmptyText(value, null),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          CustomTextField(
                            labelText: 'password'.tr,
                            titleText: '8_character'.tr,
                            controller: guestPasswordController,
                            focusNode: guestPasswordNode,
                            nextFocus: guestConfirmPasswordNode,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            required: true,
                            validator: (value) =>
                                ValidateCheck.validateEmptyText(value, null),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtremeLarge,
                          ),
                          CustomTextField(
                            labelText: 'confirm_password'.tr,
                            titleText: '8_character'.tr,
                            controller: guestConfirmPasswordController,
                            focusNode: guestConfirmPasswordNode,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            required: true,
                            validator: (value) =>
                                ValidateCheck.validateEmptyText(value, null),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
