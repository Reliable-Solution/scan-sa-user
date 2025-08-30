import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/features/location/controllers/location_controller.dart';
import 'package:scan_sa_user/features/notification/controllers/notification_controller.dart';
import 'package:scan_sa_user/features/splash/controllers/splash_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/helper/address_helper.dart';
import 'package:scan_sa_user/helper/auth_helper.dart';
import 'package:scan_sa_user/helper/route_helper.dart';
import 'package:scan_sa_user/util/dimensions.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';
import 'package:scan_sa_user/util/styles.dart';

class HomeAddressWidget extends StatelessWidget {
  const HomeAddressWidget({
    super.key,
    required this.fromBookTable,
    required this.splashController,
    required this.isSearchButton,
  });
  final bool fromBookTable;
  final bool isSearchButton;
  final SplashController splashController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.webMaxWidth,
      child: Row(
        children: [
          if (splashController.module != null &&
              splashController.configModel!.module == null &&
              splashController.moduleList != null &&
              splashController.moduleList!.length != 1) ...[
            InkWell(
              onTap: () {
                splashController.removeModule();
                Get.find<StoreController>().resetStoreData();
              },
              child: Image.asset(
                Images.moduleIcon,
                height: 25,
                width: 25,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            const SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
          ],
          Expanded(
            child: InkWell(
              onTap: () =>
                  Get.find<LocationController>().navigateToLocationScreen(
                'home',
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeSmall,
                ),
                child: GetBuilder<LocationController>(
                  builder: (locationController) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AuthHelper.isLoggedIn()
                              ? AddressHelper.getUserAddressFromSharedPref()!
                                  .addressType!
                                  .tr
                              : 'your_location'.tr,
                          style: robotoMedium.copyWith(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color,
                            fontSize: 20,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                AddressHelper.getUserAddressFromSharedPref()!
                                        .address ??
                                    '',
                                style: robotoRegular.copyWith(
                                  color: context.color.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.expand_more,
                              color: Colors.black,
                              size: 18,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: InkWell(
              child: GetBuilder<NotificationController>(
                builder: (notificationController) {
                  return Stack(
                    children: [
                      Icon(
                        CupertinoIcons.bell,
                        size: 25,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      notificationController.hasNotification
                          ? Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: Theme.of(
                                      context,
                                    ).cardColor,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
              onTap: () => Get.toNamed(
                RouteHelper.getNotificationRoute(),
              ),
            ),
          ),
          if (isSearchButton)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: InkWell(
                child: CircleAvatar(
                  backgroundColor:
                      context.color.secondary.withValues(alpha: .1),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 25,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                onTap: () => Get.toNamed(
                  RouteHelper.getSearchRoute(
                    fromBookTable: fromBookTable,
                  ),
                ),
              ),
            ),
          // if (showMobileModule)
          GestureDetector(
            onTap: () => Get.toNamed(
              RouteHelper.getInitialRoute(),
            ),
            child: CircleAvatar(
              backgroundColor: context.color.secondary.withValues(alpha: .1),
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: SvgAssets(
                  fromBookTable ? Images.bookTable : Images.orderFood,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
