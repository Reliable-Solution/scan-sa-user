import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:scan_sa_user/common/widgets/custom_image.dart';
import 'package:scan_sa_user/common/widgets/shimmer_ext.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/widgets/call_sheet.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/widgets/image_view_screen.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/widgets/restaurant_timing_sheet.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

class RestaurantReservationScreen extends StatelessWidget {
  const RestaurantReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (storeController) {
        return ValueListenableBuilder(
          valueListenable: storeController.isMenuLoad,
          builder: (context, isMenuLoad, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [
                          context.color.borderColor.withValues(alpha: 0),
                          context.color.borderColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                  ).copyWith(bottom: 22),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 13,
                  ).add(const EdgeInsets.only(top: 20)),
                  child: Row(
                    children: [
                      if (storeController.store?.schedules?.isEmpty ?? false)
                        const SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ColoredBox(color: Colors.black),
                        ).shimmer(context)
                      else
                        StoreTimingWidget(
                          scheduleList: storeController.store?.schedules ?? [],
                        ),
                      const Spacer(),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: context.color.secondary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(right: 8),
                        child: SvgPicture.asset(Images.directionIc),
                      ),
                      GestureDetector(
                        onTap: showCallSheet,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: context.color.secondary.withValues(
                              alpha: 0.1,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: SvgPicture.asset(Images.callIc),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
                  child: Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                context.color.white,
                                context.color.borderColor,
                              ],
                            ),
                          ),
                          child: const SizedBox(height: 2),
                        ),
                      ),
                      Text('MENU', style: context.style.s16w700),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                context.color.borderColor,
                                context.color.white,
                              ],
                            ),
                          ),
                          child: const SizedBox(height: 2),
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: storeController.isMenuLoad,
                  builder: (context, isMenuLoad, child) {
                    return SizedBox(
                      height: 220,
                      child: ListView.separated(
                        itemCount: isMenuLoad
                            ? 5
                            : storeController.storeMenuList.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.appPadding,
                          vertical: 20,
                        ),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final menu = isMenuLoad
                              ? null
                              : storeController.storeMenuList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MenuViewerScreen(
                                    menuList: storeController.storeMenuList,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  ColoredBox(
                                    color: context.color.borderColor,
                                    child: CustomImage(
                                      image: menu?.imageUrl ?? '',
                                      width: 200 / 1.414,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    height: 180,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          context.color.primary
                                              .withValues(alpha: .25),
                                          context.color.primary
                                              .withValues(alpha: 0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
                  child: Text('Photos', style: context.style.s22w700),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                    vertical: 10,
                  ),
                  child: StaggeredGrid.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: 2,
                        child: Image.asset(Images.restaurant),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Image.asset(Images.restaurant),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Image.asset(Images.restaurant),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Image.asset(Images.restaurant),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Image.asset(Images.restaurant),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Stack(
                          children: [
                            Image.asset(Images.restaurant),
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    context.color.primary.withValues(alpha: .5),
                              ),
                              child: Text(
                                '+3',
                                style: context.style.s22w700.copyWith(
                                  color: context.color.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                  ).copyWith(top: 20, bottom: 50),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location', style: context.style.s22w700),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const SizedBox(
                          height: 130,
                          child: GoogleMap(
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(21.02578, 72.179),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Expanded(
                            child: Text(
                              '1.3 km Shop 65-68, Ground Floor, Vip Plaza, Vip Road, Vesu, Riyadh, Dubai - 2950',
                              style: context.style.s14w700.copyWith(
                                color: context.color.ff9c9c9c,
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: context.color.secondary.withValues(
                                alpha: 0.1,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: SvgPicture.asset(Images.directionIc),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
