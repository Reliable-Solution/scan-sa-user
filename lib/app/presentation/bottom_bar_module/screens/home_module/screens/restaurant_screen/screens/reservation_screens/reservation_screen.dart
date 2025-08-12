import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/screens/reservation_screens/controller/reservation_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.fff5f5f5,
      bottomNavigationBar: AppButton(
        label: 'Reserve slot',
        isBottomPad: true,
        btnColor: context.color.greenColor,
        onPressed: () => AppPages.confirmationScreen.push(),
      ),
      body: Column(
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
                      AppIcons.arrowBackIc,
                      color: context.color.primary,
                    ),
                  ),
                  Text('Reserve Slot', style: context.style.s22w700),
                  Opacity(
                    opacity: 0,
                    child: SvgAssets(
                      AppIcons.arrowBackIc,
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
                    Text('Yam Chinese', style: context.style.s18w700),
                    BorderWidget(
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Number of guest(s)',
                              style: context.style.s18w700.copyWith(
                                color: context.color.primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 59,
                            child: ListView.builder(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ).copyWith(top: 14),
                              itemBuilder: (context, index) {
                                final isSelected =
                                    reservationController.numberOfGuest.value ==
                                    index + 1;
                                return GestureDetector(
                                  onTap: () => reservationController
                                      .changeGuest(index + 1),
                                  child: BorderWidget(
                                    radius: 10,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 17,
                                    ),
                                    margin: const EdgeInsets.only(right: 14),
                                    borderColor: isSelected
                                        ? selectedColor
                                        : null,
                                    boxColor: isSelected
                                        ? backSelectedColor
                                        : null,
                                    child: Text(
                                      '${index + 1}',
                                      style: context.style.s16w700.copyWith(
                                        color: isSelected
                                            ? selectedColor
                                            : context.color.primary,
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
                      padding: const EdgeInsets.symmetric(vertical: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Number of guest(s)',
                              style: context.style.s18w700.copyWith(
                                color: context.color.primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 89,
                            child: ListView.builder(
                              itemCount: 7,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ).copyWith(top: 14),
                              itemBuilder: (context, index) {
                                // final e = controller.dataList[index];
                                final isSelected =
                                    reservationController
                                        .visitingDateIndex
                                        .value ==
                                    index;
                                final isToday =
                                    dayList[DateTime.now().weekday - 1] ==
                                    dayList[index];

                                return GestureDetector(
                                  onTap: () =>
                                      reservationController.changeDate(index),
                                  child: BorderWidget(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    radius: 10,
                                    margin: const EdgeInsets.only(right: 14),
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
                                          isToday ? 'Today' : dayList[index],
                                          style: context.style.s14w700.copyWith(
                                            color: isSelected
                                                ? selectedColor
                                                : context.color.ff6c6c6c,
                                          ),
                                        ),
                                        Text(
                                          '11 Jul',
                                          style: context.style.s16w700.copyWith(
                                            color: isSelected
                                                ? selectedColor
                                                : context.color.primary,
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
                              horizontal: 20,
                            ).copyWith(top: 20, bottom: 10),
                            child: Text(
                              'Select the time of day to see the offers',
                              style: context.style.s18w700.copyWith(
                                color: context.color.ff6c6c6c,
                              ),
                            ),
                          ),

                          ...List.generate(controller.dataList.length, (index) {
                            final e = controller.dataList[index];
                            return BorderWidget(
                              padding: const EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSizes.appPadding,
                              ).copyWith(bottom: 16),
                              radius: 15,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller
                                        ..dataList[index].isExpand.value =
                                            !e.isExpand.value
                                        ..update();
                                    },
                                    child: Row(
                                      spacing: 20,
                                      children: [
                                        SvgAssets(e.icon),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.title,
                                                style: context.style.s16w700,
                                              ),
                                              Text(
                                                e.time,
                                                style: context.style.s12w700
                                                    .copyWith(
                                                      color: context
                                                          .color
                                                          .ff6c6c6c,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SvgAssets(
                                          AppIcons.arrowBottomIc,
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
                                      itemCount: e.timeList.length,
                                      padding: const EdgeInsets.only(top: 25),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 7,
                                            crossAxisSpacing: 12,
                                            childAspectRatio: 1.7,
                                          ),
                                      itemBuilder: (context, index) {
                                        final time = e.timeList[index];
                                        final isSelected =
                                            time ==
                                            controller.selectedTime.value;
                                        return GestureDetector(
                                          onTap: () => controller
                                            ..selectedTime.value = time
                                            ..update(),
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
                                              time,
                                              style: context.style.s12w700
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
