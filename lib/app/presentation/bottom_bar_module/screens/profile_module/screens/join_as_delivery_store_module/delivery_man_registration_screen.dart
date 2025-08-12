import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/controllers/deliveryman_registration_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/delivery_reg_second_screen.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/controllers/store_registration_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_validations.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class DeliveryManRegistrationScreen extends StatefulWidget {
  const DeliveryManRegistrationScreen({super.key});

  @override
  State<DeliveryManRegistrationScreen> createState() =>
      _DeliveryManRegistrationScreenState();
}

class _DeliveryManRegistrationScreenState
    extends State<DeliveryManRegistrationScreen> {
  final deliveryController = Get.put(
    DeliverymanRegistrationController(
      deliverymanRegistrationServiceInterface: Get.find(),
    ),
  );

  @override
  void initState() {
    super.initState();

    if (deliveryController.showPassView) {
      deliveryController.showHidePass();
    }
    deliveryController.pickDmImage(false, true);
    deliveryController.dmStatusChange(0.4, isUpdate: false);
    Get.put(
      StoreRegistrationController(
        locationServiceInterface: Get.find(),
        storeRegistrationServiceInterface: Get.find(),
      ),
    ).validPassCheck('', isUpdate: false);
    deliveryController.setIdentityTypeIndex(0, false);
    deliveryController.setDMTypeIndex(0, false);
    deliveryController.getZoneList();
    deliveryController.getVehicleList();
  }

  bool isSecondScreen = false;

  @override
  void dispose() {
    deliveryController
      ..lNameController.clear()
      ..fNameController.clear()
      ..emailController.clear()
      ..phoneController.clear()
      ..passwordController.clear()
      ..confirmPasswordController.clear()
      ..identityNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (context) {
          return Scaffold(
            // backgroundColor: Get.find<GlobalController>().isDark
            //     ? context.color.whiteLight
            //     : context.color.fff5f5f5,
            bottomNavigationBar: Padding(
              padding: AppPadding.bottomPad(context),
              child: Row(
                spacing: 10,
                children: [
                  if (isSecondScreen)
                    Expanded(
                      child: AppButton(
                        label: 'back'.tr,
                        btnColor: context.color.grey,
                        txtColor: context.color.primary,
                        // buttonType: ButtonType.,
                        onPressed: () {
                          setState(() {
                            isSecondScreen = false;
                          });
                        },
                      ),
                    ),
                  Expanded(
                    child: AppButton(
                      label: isSecondScreen ? 'submit'.tr : 'next'.tr,
                      onPressed: () {
                        if (!Form.of(context).validate()) return;
                        if (isSecondScreen) {
                          deliveryController.registerDeliveryMan();
                        } else {
                          setState(() {
                            isSecondScreen = true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              leadingWidth: AppSizes.appPadding + 40,
              leading: Padding(
                padding: EdgeInsets.only(left: AppSizes.appPadding),
                child: const BackBtn(),
              ),
              title: Text(
                'delivery_man_registration'.tr,
                style: context.style.s22w700,
              ),
            ),
            body: GetBuilder<DeliverymanRegistrationController>(
              builder: (controller) {
                return ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                    vertical: 10,
                  ),
                  children: [
                    if (isSecondScreen)
                      const DeliveryRegSecondScreen()
                    else
                      const DeliveryManFirstScreen(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DeliveryManFirstScreen extends StatelessWidget {
  const DeliveryManFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliverymanRegistrationController>(
      builder: (controller) {
        return Column(
          children: [
            Align(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: context.color.lightText,
                    child: ClipOval(
                      child: controller.pickedImage == null
                          ? const Icon(Icons.person, size: 30)
                          : Image.file(
                              File(controller.pickedImage?.path ?? ''),
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async => controller.pickDmImage(true, false),
                    child: CircleAvatar(
                      backgroundColor: context.color.secondary,
                      radius: 13,
                      child: Icon(
                        Icons.edit,
                        size: 13,
                        color: context.color.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AppTextField(
                      hintText: 'first_name'.tr,
                      controller: controller.fNameController,
                      maxLength: 10,
                      validator: (value) =>
                          AppValidations.emptyFieldValidation(value, null),
                    ),
                  ),
                  Expanded(
                    child: AppTextField(
                      hintText: 'last_name'.tr,
                      controller: controller.lNameController,
                      maxLength: 10,
                      validator: (value) =>
                          AppValidations.emptyFieldValidation(value, null),
                    ),
                  ),
                ],
              ),
            ),
            AppTextField(
              hintText: context.l10n.phone,
              controller: controller.phoneController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  AppValidations.emptyFieldValidation(value, null),
            ),
            AppTextField(
              hintText: context.l10n.email,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  AppValidations.emptyFieldValidation(value, null),
            ),
            Obx(() {
              final passObscureText = controller.passObscureText.value;
              return AppTextField(
                hintText: context.l10n.password,
                bottomPadding: 12,
                controller: controller.passwordController,
                obscureText: passObscureText,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: SvgAssets(
                    passObscureText ? AppIcons.closeEyeIc : AppIcons.openEyeIc,
                  ),
                  onPressed: controller.toggleObscureText,
                ),
                validator: (value) =>
                    AppValidations.passFieldValidation(value, context),
              );
            }),
            Obx(() {
              final conPassObscureText = controller.conPassObscureText.value;
              return AppTextField(
                hintText: context.l10n.confirmPassword,
                bottomPadding: 12,
                controller: controller.confirmPasswordController,
                textInputAction: TextInputAction.done,
                obscureText: conPassObscureText,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: SvgAssets(
                    conPassObscureText
                        ? AppIcons.closeEyeIc
                        : AppIcons.openEyeIc,
                  ),
                  onPressed: () => controller.toggleObscureText(isPass: false),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return context.l10n.pleaseEnterConfirmPassword;
                  } else if (value != controller.passwordController.text) {
                    return 'Password and confirm password does not match';
                  } else {
                    return null;
                  }
                },
              );
            }),
          ],
        );
      },
    );
  }
}
