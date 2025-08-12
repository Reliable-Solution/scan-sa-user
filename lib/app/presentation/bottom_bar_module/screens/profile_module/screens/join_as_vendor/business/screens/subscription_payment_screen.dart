import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_vendor/business/controllers/business_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class SubscriptionPaymentScreen extends StatefulWidget {
  const SubscriptionPaymentScreen({
    super.key,
    required this.storeId,
    required this.packageId,
  });
  final int? storeId;
  final int? packageId;

  @override
  State<SubscriptionPaymentScreen> createState() =>
      _SubscriptionPaymentScreenState();
}

class _SubscriptionPaymentScreenState extends State<SubscriptionPaymentScreen> {
  @override
  void initState() {
    super.initState();

    Get.put<BusinessController>(
      BusinessController(businessServiceInterface: Get.find()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessController>(
      builder: (businessController) {
        return CommonSubAppBarScreen(
          title: 'payment'.tr,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            children: [
              if (Get.find<GlobalController>()
                      .configModel!
                      .subscriptionFreeTrialStatus ??
                  false)
                GestureDetector(
                  onTap: () => businessController.setPaymentIndex(0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: businessController.paymentIndex == 0
                            ? context.color.greenColor
                            : context.color.ff6c6c6c,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: context.color.white,
                    ),
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    child: Text(
                      '${'continue_with'.tr} ${Get.find<GlobalController>().configModel!.subscriptionFreeTrialDays} '
                      '${Get.find<GlobalController>().configModel!.subscriptionFreeTrialType} ${'days_free_trial'.tr}',
                      style: context.style.s16w700.copyWith(
                        color: businessController.paymentIndex == 0
                            ? context.color.greenColor
                            : context.color.ff6c6c6c,
                      ),
                    ),
                  ),
                ),
              if (Get.find<GlobalController>().configModel!.digitalPayment!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        '${'pay_via_online'.tr} ${'faster_and_secure_way_to_pay_bill'.tr}',
                        style: context.style.s16w500,
                      ),
                    ),

                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: Dimensions.paddingSizeLarge,
                            mainAxisSpacing: Dimensions.paddingSizeLarge,
                            mainAxisExtent: 55,
                          ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: Get.find<GlobalController>()
                          .configModel!
                          .activePaymentMethodList!
                          .length,
                      itemBuilder: (context, index) {
                        final isSelected =
                            businessController.paymentIndex == 1 &&
                            Get.find<GlobalController>()
                                    .configModel!
                                    .activePaymentMethodList![index]
                                    .getWay! ==
                                businessController.digitalPaymentName;

                        return InkWell(
                          onTap: () {
                            businessController.setPaymentIndex(1);
                            businessController.changeDigitalPaymentName(
                              Get.find<GlobalController>()
                                  .configModel!
                                  .activePaymentMethodList![index]
                                  .getWay,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: 0.05)
                                  : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusDefault,
                              ),
                              border: isSelected
                                  ? Border.all(
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.secondary
                                          : Theme.of(context).disabledColor,
                                    )
                                  : null,
                              boxShadow: isSelected
                                  ? null
                                  : [
                                      const BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      ),
                                    ],
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                              vertical: Dimensions.paddingSizeDefault,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.secondary
                                        : Theme.of(context).cardColor,
                                    border: Border.all(
                                      color: isSelected
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.secondary
                                          : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Theme.of(context).cardColor,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: Dimensions.paddingSizeDefault,
                                ),
                                Text(
                                  Get.find<GlobalController>()
                                      .configModel!
                                      .activePaymentMethodList![index]
                                      .getWayTitle!,
                                ),
                                const Spacer(),
                                CacheImageNetwork(
                                  '${Get.find<GlobalController>().configModel!.activePaymentMethodList![index].getWayImageFullUrl}',
                                  height: 20,
                                  boxFit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: Dimensions.paddingSizeDefault,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: AppButton(
                  label: 'confirm'.tr,
                  onPressed: () {
                    // '==>> widget.storeId ${widget.storeId}'.print;
                    businessController.submitBusinessPlan(
                      storeId: widget.storeId ?? 0,
                      packageId: widget.packageId,
                    );
                  },
                ),
              ),
            ],
          ),
          // body: Column(children: [

          //   WebScreenTitleWidget(title: 'join_as_vendor'.tr),

          //   const SizedBox(height: Dimensions.paddingSizeExtraOverLarge),

          //   if (isDesktop) SizedBox(
          //     width: Dimensions.webMaxWidth,
          //     child: Padding(
          //       padding: const EdgeInsets.only(bottom: 30),
          //       child: RegistrationStepperWidget(status: Get.find<BusinessController>().businessPlanStatus),
          //     ),
          //   ) else Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical:  Dimensions.paddingSizeSmall),
          //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          //       Text(
          //         'vendor_registration'.tr,
          //         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
          //       ),

          //       Text(
          //         'you_are_one_step_away_choose_your_business_plan'.tr,
          //         style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
          //       ),

          //       const SizedBox(height: Dimensions.paddingSizeSmall),

          //       LinearProgressIndicator(
          //         backgroundColor: Theme.of(context).disabledColor, minHeight: 2,
          //         value: 0.75,
          //       ),
          //     ],),
          //   ),

          //   Expanded(
          //     child: SingleChildScrollView(
          //       child: FooterView(
          //         minHeight: 0.45,
          //         child: SizedBox(
          //           width: Dimensions.webMaxWidth,
          //           child: Column(children: [

          //             Container(
          //               margin: EdgeInsets.only(top: isDesktop ? Dimensions.paddingSizeSmall : 0),
          //               decoration: isDesktop ? BoxDecoration(
          //                 color: Theme.of(context).cardColor,
          //                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          //                 boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
          //               ) : null,
          //               padding: EdgeInsets.symmetric(
          //                 horizontal: isDesktop ? 50 : 0,
          //                 vertical:  isDesktop ? Dimensions.paddingSizeDefault : 0,
          //               ),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          //                 child: Column(children: [

          //                   if (Get.find<GlobalController>().configModel!.subscriptionFreeTrialStatus ?? false) PaymentCartWidget(
          //                     title: '${'continue_with'.tr} ${Get.find<GlobalController>().configModel!.subscriptionFreeTrialDays} '
          //                         '${Get.find<GlobalController>().configModel!.subscriptionFreeTrialType} ${'days_free_trial'.tr}',
          //                     index: 0,
          //                     onTap: () {
          //                       businessController.setPaymentIndex(0);
          //                     },
          //                   ) else const SizedBox(),
          //                   SizedBox(height: Get.find<GlobalController>().configModel!.subscriptionFreeTrialStatus??false ? Dimensions.paddingSizeExtremeLarge : 0),

          //                   if (Get.find<GlobalController>().configModel!.digitalPayment!) Column(children: [
          //                     Row(children: [
          //                       Text('${'pay_via_online'.tr} ', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
          //                       Text(
          //                         'faster_and_secure_way_to_pay_bill'.tr,
          //                         style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
          //                       ),
          //                     ],),

          //                     SizedBox(height: isDesktop ? Dimensions.paddingSizeLarge : 0),

          //                     GridView.builder(
          //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                         crossAxisCount: isDesktop ? 3 : ResponsiveHelper.isTab(context) ? 2 : 1,
          //                         crossAxisSpacing: Dimensions.paddingSizeLarge,
          //                         mainAxisSpacing: Dimensions.paddingSizeLarge,
          //                         mainAxisExtent: 55,
          //                       ),
          //                       physics: const NeverScrollableScrollPhysics(),
          //                       shrinkWrap: true,
          //                       itemCount: Get.find<GlobalController>().configModel!.activePaymentMethodList!.length,
          //                       itemBuilder: (context, index) {
          //                         final var isSelected = businessController.paymentIndex == 1 && Get.find<GlobalController>().configModel!.activePaymentMethodList![index].getWay! == businessController.digitalPaymentName;

          //                         return InkWell(
          //                           onTap: (){
          //                             businessController.setPaymentIndex(1);
          //                             businessController.changeDigitalPaymentName(Get.find<GlobalController>().configModel!.activePaymentMethodList![index].getWay);
          //                           },
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.05) : Theme.of(context).cardColor,
          //                               borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          //                               border: isSelected ? Border.all(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, width: 0.3) : null,
          //                               boxShadow: isSelected ? null : [const BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
          //                             ),
          //                             padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault),
          //                             child: Row(children: [
          //                               Container(
          //                                 height: 20, width: 20,
          //                                 decoration: BoxDecoration(
          //                                   shape: BoxShape.circle, color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
          //                                   border: Border.all(color: Theme.of(context).disabledColor),
          //                                 ),
          //                                 child: Icon(Icons.check, color: Theme.of(context).cardColor, size: 16),
          //                               ),
          //                               const SizedBox(width: Dimensions.paddingSizeDefault),

          //                               Text(
          //                                 Get.find<GlobalController>().configModel!.activePaymentMethodList![index].getWayTitle!,
          //                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
          //                               ),
          //                               const Spacer(),

          //                               CustomImage(
          //                                 height: 20, fit: BoxFit.contain,
          //                                 image: '${Get.find<GlobalController>().configModel!.activePaymentMethodList![index].getWayImageFullUrl}',
          //                               ),
          //                               const SizedBox(width: Dimensions.paddingSizeDefault),

          //                             ],),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                     SizedBox(height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
          //                   ],) else const SizedBox(),

          //                 ],),
          //               ),
          //             ),

          //             SizedBox(height: isDesktop ? Dimensions.paddingSizeExtremeLarge : 0),

          //             if (isDesktop) Row(mainAxisAlignment: MainAxisAlignment.end, children: [

          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          //                   border: Border.all(color: Theme.of(context).disabledColor.withValues(alpha: 0.3)),
          //                 ),
          //                 width: 120,
          //                 child: CustomButton(
          //                   transparent: true,
          //                   textColor: Theme.of(context).disabledColor,
          //                   radius: Dimensions.radiusSmall,
          //                   onPressed: () {
          //                     Get.back();
          //                   },
          //                   buttonText: 'back'.tr,
          //                   isBold: false,
          //                   fontSize: Dimensions.fontSizeSmall,
          //                 ),
          //               ),
          //               const SizedBox(width: Dimensions.paddingSizeLarge),

          //               CustomButton(
          //                 textColor: Theme.of(context).cardColor,
          //                 radius: Dimensions.radiusSmall,
          //                 width: 140,
          //                 buttonText: 'confirm'.tr,
          //                 onPressed: () {
          //                   businessController.submitBusinessPlan(storeId: widget.storeId, packageId: widget.packageId);
          //                 },
          //                 isBold: false,
          //                 fontSize: Dimensions.fontSizeSmall,
          //               ),

          //             ],) else const SizedBox(),

          //           ],),
          //         ),
          //       ),
          //     ),
          //   ),

          //   if (!isDesktop) Container(
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).cardColor,
          //       boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5)],
          //     ),
          //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
          //     child: CustomButton(
          //       buttonText: 'confirm'.tr,
          //       isLoading: businessController.isLoading,
          //       onPressed: () {
          //         businessController.submitBusinessPlan(storeId: widget.storeId, packageId: widget.packageId);
          //       },
          //     ),
          //   ) else const SizedBox(),

          // ],),
        );
      },
    );
  }

  // void _showBackPressedDialogue(String title){
  //   Get.dialog(ConfirmationDialog(icon: Images.support,
  //     title: title,
  //     description: 'are_you_sure_to_go_back'.tr, isLogOut: true,
  //     onYesPressed: () {
  //       if(Get.isDialogOpen!){
  //         Get.back();
  //       }
  //       Get.back();
  //     },
  //   ), useSafeArea: false,);
  // }
}
