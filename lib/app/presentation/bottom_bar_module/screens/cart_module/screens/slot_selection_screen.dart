import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/slot_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/screens/checkout_module/controllers/checkout_controller.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class SlotSelectionScreen extends StatefulWidget {
  const SlotSelectionScreen({
    super.key,
    required this.isTodayClosed,
    required this.isTomorrowClosed,
  });
  final bool isTodayClosed;
  final bool isTomorrowClosed;

  @override
  State<SlotSelectionScreen> createState() => _SlotSelectionScreenState();
}

class _SlotSelectionScreenState extends State<SlotSelectionScreen>
    with TickerProviderStateMixin {
  final slotController = Get.put(SlotController());
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (checkoutController) {
        return CommonSubScreen(
          appBarTitle: context.l10n.selectPreferenceTime,
          btnText: context.l10n.schedule,
          onTap: Get.back,
          child: Obx(() {
            final isToday = checkoutController.isToday.value;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      textBtn(
                        context,
                        title: context.l10n.today,
                        index: 0,
                        isSelected: isToday,
                      ),
                      textBtn(
                        context,
                        title: context.l10n.tomorrow,
                        index: 1,
                        isSelected: !isToday,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.appPadding,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Divider(color: context.color.grey),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedContainer(
                              duration: Durations.short4,
                              height: isToday ? 5 : 0,
                              color: isToday
                                  ? context.color.secondary
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: AnimatedContainer(
                              duration: Durations.short4,
                              height: isToday ? 0 : 5,
                              color: isToday
                                  ? Colors.transparent
                                  : context.color.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: checkoutController.timeSlots.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.appPadding,
                      vertical: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 4,
                        ),
                    itemBuilder: (context, index) {
                      final slot = checkoutController.timeSlots[index];
                      final slotTime =
                          '${DateFormat('hh:mm a').format(slot.startTime!)}'
                          ' - ${DateFormat('hh:mm a').format(slot.endTime!)}';
                      final isSelected =
                          checkoutController.selectedTime.value == slotTime &&
                          checkoutController.isSecToday.value ==
                              checkoutController.isToday.value;
                      return GestureDetector(
                        onTap: () =>
                            checkoutController.changeSelectedTime(slotTime),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? context.color.primary
                                  : context.color.lightText,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            isToday && index == 0
                                ? context.l10n.instant
                                : '${DateFormat('hh:mm a').format(slot.startTime!)}'
                                      ' - ${DateFormat('hh:mm a').format(slot.endTime!)}',
                            style: context.style.s14w700.copyWith(
                              color: isSelected
                                  ? context.color.primary
                                  : context.color.ff6c6c6c,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget textBtn(
    BuildContext context, {
    required String title,
    required int index,
    bool isSelected = false,
  }) {
    final isToday = title == context.l10n.today;
    final checkoutController = Get.find<CheckoutController>();
    return Expanded(
      child: GestureDetector(
        onTap: () {
          checkoutController.changeTime(isToday);
          checkoutController.updateDateSlot(
            index,
            checkoutController.store!.orderPlaceToScheduleInterval,
          );
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.style.s18w700.copyWith(
              color: isSelected
                  ? context.color.secondary
                  : context.color.primary,
            ),
          ),
        ),
      ),
    );
  }
}
