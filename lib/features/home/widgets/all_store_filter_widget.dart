import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/features/home/widgets/filter_view.dart';
import 'package:scan_sa_user/features/home/widgets/store_filter_button_widget.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/helper/responsive_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/styles.dart';

class AllStoreFilterWidget extends StatelessWidget {
  const AllStoreFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (storeController) {
        return Center(
          child: Container(
            width: Dimensions.webMaxWidth,
            transform: Matrix4.translationValues(0, -2, 0),
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.only(
              left: Dimensions.paddingSizeDefault,
              top: Dimensions.paddingSizeSmall,
            ),
            child: ResponsiveHelper.isDesktop(context)
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Get.find<SplashController>()
                                      .configModel!
                                      .moduleConfig!
                                      .module!
                                      .showRestaurantText!
                                  ? 'restaurants'.tr
                                  : 'stores'.tr,
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                            Text(
                              '${storeController.storeModel?.totalSize ?? 0} ${Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'restaurants_near_you'.tr : 'stores_near_you'.tr}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: robotoRegular.copyWith(
                                color: Theme.of(context).disabledColor,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      filter(context, storeController),
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: Dimensions.paddingSizeSmall,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Get.find<SplashController>()
                                      .configModel!
                                      .moduleConfig!
                                      .module!
                                      .showRestaurantText!
                                  ? 'restaurants'.tr
                                  : 'stores'.tr,
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${storeController.storeModel?.totalSize ?? 0} ${Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'restaurants_near_you'.tr : 'stores_near_you'.tr}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: robotoRegular.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      filter(context, storeController),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget filter(BuildContext context, StoreController storeController) {
    return SizedBox(
      height: ResponsiveHelper.isDesktop(context) ? 40 : 30,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  // ResponsiveHelper.isDesktop(context)
                  //     ? const SizedBox()
                  //     : FilterView(storeController: storeController),
                  StoreFilterButtonWidget(
                    buttonText: 'all'.tr,
                    onTap: () => storeController.setStoreType('all'),
                    isSelected: storeController.storeType == 'all',
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  StoreFilterButtonWidget(
                    buttonText: 'newly_joined'.tr,
                    onTap: () => storeController.setStoreType('newly_joined'),
                    isSelected: storeController.storeType == 'newly_joined',
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  StoreFilterButtonWidget(
                    buttonText: 'popular'.tr,
                    onTap: () => storeController.setStoreType('popular'),
                    isSelected: storeController.storeType == 'popular',
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  StoreFilterButtonWidget(
                    buttonText: 'top_rated'.tr,
                    onTap: () => storeController.setStoreType('top_rated'),
                    isSelected: storeController.storeType == 'top_rated',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
            child: VerticalDivider(
              color: context.color.secondary.withValues(alpha: .6),
              width: 1.2,
              thickness: 1.2,
            ),
          ),
          FilterView(storeController: storeController),
        ],
      ),
    );
  }
}
