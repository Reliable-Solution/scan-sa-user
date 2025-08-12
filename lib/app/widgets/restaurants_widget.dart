import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/controllers/favorite_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/app/widgets/login_sheet.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/box_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class RestaurantsWidget extends StatelessWidget {
  const RestaurantsWidget({
    super.key,
    required this.index,
    this.store,
    this.isReservation = false,
  });
  final int index;
  final Store? store;
  final bool isReservation;

  @override
  Widget build(BuildContext context) {
    final isLoad = store == null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GestureDetector(
        onTap: () => store != null
            ? AppPages.restaurantScreen.push(
                arguments: {
                  'index': index,
                  'store': store?.toJson(),
                  'isReservation': isReservation,
                },
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                transitionOnUserGestures: true,
                tag: '${store?.logoFullUrl}$index',
                child: CacheImageNetwork(
                  store?.logoFullUrl ?? '',
                  height: 180,
                  width: double.infinity,
                  // boxFit: BoxFit.cover,
                ),
              ),
            ).shimmer(context, isLoad: isLoad),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isLoad)
                    const BoxShimmer(height: 14, width: 120)
                  else
                    Expanded(
                      child: Text(
                        store?.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.style.s18w700.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.color.primary,
                        ),
                      ),
                    ),
                  FavoriteIcon(storeId: store?.id ?? 0, isLoad: isLoad),
                ],
              ),
            ),
            if (isLoad)
              const BoxShimmer(height: 14, width: 200)
            else
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: context.color.secondary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 6,
                    ),
                    child: Row(
                      spacing: 4,
                      children: [
                        SvgAssets(AppIcons.deliveryBoyIc),
                        Text(
                          context.l10n.free,
                          style: context.style.s12w700.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (store?.deliveryTime?.isNotEmpty ?? false)
                    Text(' • ', style: context.style.s12w700),
                  if (store?.deliveryTime?.isNotEmpty ?? false)
                    Text(
                      store?.deliveryTime ?? '',
                      style: context.style.s14w700.copyWith(
                        color: context.color.ff828282,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.storeId, required this.isLoad});
  final int storeId;
  final bool isLoad;

  @override
  Widget build(BuildContext context) {
    final isGuest = Get.find<GlobalController>().isGuestMode;
    return GetBuilder<FavoriteController>(
      builder: (favController) {
        return GestureDetector(
          onTap: () => isGuest
              ? showLoginSheet()
              : favController.isFav(storeId)
              ? favController.removeFromFavoriteList(storeId, true)
              : favController.addToFavoriteList(null, storeId, true),
          child: SvgAssets(
            favController.isFav(storeId)
                ? AppIcons.likeDarkIc
                : AppIcons.likeIc,
            color: Get.find<GlobalController>().isDark
                ? context.color.primary
                : null,
          ).shimmer(context, isLoad: isLoad),
        );
      },
    );
  }
}
