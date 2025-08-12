import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    this.color,
    this.isSearchButton = false,
    this.isCategoryScreen = false,
  });
  final Color? color;
  final bool isSearchButton;
  final bool isCategoryScreen;

  @override
  Widget build(BuildContext context) {
    final globalController = Get.find<GlobalController>();
    return Obx(() {
      final address = globalController.addressModel.value;
      return Row(
        spacing: 10,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: AppPages.locationHomeScreen.push,
              child: Row(
                spacing: 10,
                children: [
                  SvgAssets(
                    AppIcons.locationFillIc,
                    color: color ?? context.color.primary,
                  ),
                  Expanded(
                    child: Column(
                      spacing: 3,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address?.addressType ?? 'default'.tr,
                          style: context.style.s20w900.copyWith(color: color),
                        ),
                        Text(
                          address?.address ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.style.s16w300.copyWith(color: color),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSearchButton)
            GestureDetector(
              onTap: () => AppPages.searchScreen.push(),
              child: CircleAvatar(
                backgroundColor: color ?? context.color.primary,
                child: SvgAssets(
                  AppIcons.searchIc,
                  color: color == null
                      ? context.color.white
                      : context.color.primary,
                ),
              ),
            ),
          if (isCategoryScreen)
            GetBuilder<GlobalController>(
              builder: (controller) {
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: GestureDetector(
                    onTap: () => AppPages.categoryScreen.push(),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.color.primary.withValues(alpha: .5),
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Hero(
                              tag: controller.module?.moduleName ?? '',
                              child: CacheImageNetwork(
                                controller.module?.iconFullUrl ?? '',
                                height: 30,
                                radius: 30,
                                color: Colors.transparent,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: context.color.primary.withValues(
                                alpha: .5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      );
    });
  }
}
