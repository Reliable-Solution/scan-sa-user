import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/controller/reservation_controller.dart';
import 'package:scan_sa_user/features/store/controllers/store_controller.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final reservationController = Get.put(ReservationController());
  final dayList = ['Mon', 'Tues', 'Wed', 'Thurs', 'Fri', 'Sat', 'Sun'];
  final selectedColor = const Color(0xFFFFA100);
  final backSelectedColor = const Color(0xFFFFFAEF);

  @override
  void initState() {
    Get.find<ReservationController>().generateNext30DaysSlots(
      Get.find<StoreController>().store!.schedules!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.fff5f5f5,
      bottomNavigationBar: AppButton(
        buttonText: 'Reserve slot',
        isBottomPad: true,
        color: context.color.greenColor,
        // onPressed: () => AppPages.confirmationScreen.push(),
      ),
      body: GetBuilder<StoreController>(
        builder: (storeController) {
          return GetBuilder<ReservationController>(
            builder: (reservationController) {
              return Column(
                children: [
                  ColoredBox(
                    color: context.color.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.paddingOf(context).top + 10,
                        bottom: 6,
                        right: AppSizes.appPadding,
                        left: AppSizes.appPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: Get.back,
                            child: SvgAssets(
                              Images.arrowBackIc,
                              color: context.color.secondary,
                            ),
                          ),
                          Text('Reserve Slot', style: context.style.s22w700),
                          Opacity(
                            opacity: 0,
                            child: SvgAssets(
                              Images.arrowBackIc,
                              color: context.color.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          context.color.white,
                          context.color.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<ReservationController>(
                      builder: (controller) {
                        return ListView(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.appPadding,
                          ),
                          children: [
                            Text(
                              storeController.store?.name ?? "",
                              style: context.style.s20w900
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            BorderWidget(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      'Number of guest(s)',
                                      style: context.style.s16w700.copyWith(
                                        color: context.color.secondary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 59,
                                    child: ListView.builder(
                                      itemCount: 10,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ).copyWith(top: 14),
                                      itemBuilder: (context, index) {
                                        final isSelected = reservationController
                                                .numberOfGuest.value ==
                                            index + 1;
                                        return GestureDetector(
                                          onTap: () => reservationController
                                              .changeGuest(index + 1),
                                          child: BorderWidget(
                                            radius: 10,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 17,
                                            ),
                                            margin: const EdgeInsets.only(
                                              right: 14,
                                            ),
                                            borderColor: isSelected
                                                ? selectedColor
                                                : null,
                                            boxColor: isSelected
                                                ? backSelectedColor
                                                : null,
                                            child: Text(
                                              '${index + 1}',
                                              style: context.style.s16w700
                                                  .copyWith(
                                                color: isSelected
                                                    ? context.color.primary
                                                    : context.color.grey,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            BorderWidget(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      'When are you visiting?',
                                      style: context.style.s16w700.copyWith(
                                        color: context.color.secondary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 89,
                                    child: ListView.builder(
                                      itemCount: reservationController
                                          .slotsByDay.length,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ).copyWith(top: 14),
                                      itemBuilder: (context, index) {
                                        final slot = reservationController
                                            .slotsByDay[index];
                                        // final e = controller.dataList[index];
                                        final isSelected = reservationController
                                                .visitingDateIndex.value ==
                                            index;
                                        return GestureDetector(
                                          onTap: () => reservationController
                                              .changeDate(index),
                                          child: BorderWidget(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            radius: 10,
                                            margin: const EdgeInsets.only(
                                              right: 14,
                                            ),
                                            borderColor: isSelected
                                                ? selectedColor
                                                : null,
                                            boxColor: isSelected
                                                ? backSelectedColor
                                                : null,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  slot.isToday
                                                      ? 'Today'
                                                      : slot.day,
                                                  style: context.style.s14w700
                                                      .copyWith(
                                                    color: isSelected
                                                        ? selectedColor
                                                        : context.color.grey,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('dd MMM')
                                                      .format(slot.date),
                                                  style: context.style.s16w700
                                                      .copyWith(
                                                    color: isSelected
                                                        ? selectedColor
                                                        : context.color.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ).copyWith(top: 20, bottom: 10),
                                    child: Text(
                                      'Select the time of day to see the offers',
                                      style: context.style.s16w700.copyWith(
                                        color: context.color.secondary,
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                      reservationController
                                          .slotsByDay[reservationController
                                              .visitingDateIndex.value]
                                          .slotList
                                          .length, (index) {
                                    final e = reservationController
                                        .slotsByDay[reservationController
                                            .visitingDateIndex.value]
                                        .slotList[index];
                                    return BorderWidget(
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ).copyWith(bottom: 16),
                                      radius: 15,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              reservationController
                                                ..slotsByDay[
                                                        reservationController
                                                            .visitingDateIndex
                                                            .value]
                                                    .slotList[index]
                                                    .isExpand
                                                    .value = !e.isExpand.value
                                                ..update();
                                            },
                                            child: Row(
                                              spacing: 20,
                                              children: [
                                                SvgAssets(e.icon),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e.title,
                                                        style: context
                                                            .style.s16w700,
                                                      ),
                                                      Text(
                                                        e.time,
                                                        style: context
                                                            .style.s12w700
                                                            .copyWith(
                                                          color: context
                                                              .color.ff6c6c6c,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SvgAssets(
                                                  Images.arrowBottomIc,
                                                  height: 10,
                                                  color: context.color.ff6c6c6c,
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (e.isExpand.value)
                                            GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: e.slotList.length,
                                              padding: const EdgeInsets.only(
                                                top: 25,
                                              ),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 7,
                                                crossAxisSpacing: 12,
                                                childAspectRatio: 1.7,
                                              ),
                                              itemBuilder: (context, index) {
                                                final time = e.slotList[index];
                                                final isSelected = time.start ==
                                                    controller.selectedTime;
                                                return GestureDetector(
                                                  onTap: () {
                                                    controller
                                                      ..selectedTime =
                                                          time.start
                                                      ..update();
                                                  },
                                                  child: BorderWidget(
                                                    radius: 10,
                                                    padding: EdgeInsets.zero,
                                                    borderColor: isSelected
                                                        ? selectedColor
                                                        : null,
                                                    boxColor: isSelected
                                                        ? backSelectedColor
                                                        : null,
                                                    child: Text(
                                                      DateFormat('hh:mm a')
                                                          .format(time.start),
                                                      style: context
                                                          .style.s12w700
                                                          .copyWith(
                                                        color: isSelected
                                                            ? selectedColor
                                                            : null,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class BorderWidget extends StatelessWidget {
  const BorderWidget({
    super.key,
    required this.child,
    this.borderColor,
    this.boxColor,
    this.padding,
    this.margin,
    this.radius,
  });
  final Widget child;
  final Color? borderColor;
  final Color? boxColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? context.color.borderColor),
        color: boxColor ?? context.color.white,
        borderRadius: BorderRadius.circular(radius ?? 20),
      ),
      padding: padding ?? const EdgeInsets.all(20),
      margin: margin,
      child: child,
    );
  }
}
