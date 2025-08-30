import 'package:scan_sa_user/common/widgets/custom_asset_image_widget.dart';
import 'package:scan_sa_user/features/language/screens/web_language_screen.dart';
import 'package:scan_sa_user/features/language/widgets/language_card_widget.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/styles.dart';
import 'package:scan_sa_user/common/widgets/custom_app_bar.dart';
import 'package:scan_sa_user/common/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/features/language/controllers/language_controller.dart';
import 'package:scan_sa_user/util/app_constants.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/common/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key, this.fromMenu = false});
  final bool fromMenu;

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.fromMenu || ResponsiveHelper.isDesktop(context))
          ? CustomAppBar(title: 'language'.tr, backButton: true)
          : null,
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<LocalizationController>(
        builder: (localizationController) {
          return ResponsiveHelper.isDesktop(context)
              ? const WebLanguageScreen()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 60),
                        child: CustomAssetImageWidget(
                          Images.languageIc,
                          height: 210,
                          width: 210,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      child: Text(
                        'choose_your_language'.tr,
                        style: robotoBold.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge,
                      ),
                      child: Text(
                        'choose_your_language_to_proceed'.tr,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: context.color.darkTextGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: localizationController.languages.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeLarge,
                          ),
                          itemBuilder: (context, index) {
                            return LanguageCardWidget(
                              languageModel:
                                  localizationController.languages[index],
                              localizationController: localizationController,
                              index: index,
                            );
                          },
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeDefault,
                          horizontal: Dimensions.paddingSizeExtraLarge,
                        ),
                        // decoration: BoxDecoration(
                        //   // color: Theme.of(context).cardColor,
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.grey.withValues(alpha: 0.3),
                        //       blurRadius: 10,
                        //       spreadRadius: 0,
                        //     ),
                        //   ],
                        // ),
                        child: AppButton(
                          buttonText: 'next'.tr,
                          onPressed: () {
                            if (localizationController.languages.isNotEmpty &&
                                localizationController.selectedLanguageIndex !=
                                    -1) {
                              localizationController.setLanguage(
                                Locale(
                                  AppConstants
                                      .languages[localizationController
                                          .selectedLanguageIndex]
                                      .languageCode!,
                                  AppConstants
                                      .languages[localizationController
                                          .selectedLanguageIndex]
                                      .countryCode,
                                ),
                              );
                              if (widget.fromMenu) {
                                Navigator.pop(context);
                              } else {
                                Get.offNamed(RouteHelper.getOnBoardingRoute());
                              }
                            } else {
                              showCustomSnackBar('select_a_language'.tr);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
