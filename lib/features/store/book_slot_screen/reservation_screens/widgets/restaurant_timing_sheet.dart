import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/common/widgets/app_image_widget.dart';
import 'package:scan_sa_user/common/widgets/app_rich_text.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/widgets/common_sheet.dart';
import 'package:scan_sa_user/features/store/domain/models/store_model.dart';
import 'package:scan_sa_user/helper/string_extension.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';
import 'package:scan_sa_user/util/images.dart';

class StoreTimingWidget extends StatefulWidget {
  const StoreTimingWidget({super.key, required this.scheduleList});
  final List<Schedules> scheduleList;

  @override
  State<StoreTimingWidget> createState() => _StoreTimingWidgetState();
}

class _StoreTimingWidgetState extends State<StoreTimingWidget> {
  String openTill = '';

  @override
  void initState() {
    openTill = widget.scheduleList.firstWhereOrNull((e) {
          int hr =
              int.tryParse(e.closingTime?.split(':').firstOrNull ?? '0') ?? 0;
          int min =
              int.tryParse(e.closingTime?.split(':').lastOrNull ?? '0') ?? 0;
          int openHr =
              int.tryParse(e.openingTime?.split(':').firstOrNull ?? '0') ?? 0;
          int openMin =
              int.tryParse(e.openingTime?.split(':').lastOrNull ?? '0') ?? 0;

          "===>> $hr ==== $min ==== ${DateTime.now().hour}".print;

          return e.day == DateTime.now().weekday &&
              hr >= DateTime.now().hour &&
              openHr <= DateTime.now().hour &&
              (hr == DateTime.now().hour
                  ? min > DateTime.now().minute
                  : true) &&
              (hr == DateTime.now().hour
                  ? openMin <= DateTime.now().minute
                  : true);
        })?.closingTime ??
        '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showTimingSheet(widget.scheduleList),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: context.color.secondary.withValues(
            alpha: 0.1,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            AppRichText(
              text1: openTill.isEmpty ? 'closed_now'.tr : 'Open'.tr,
              text2: openTill.isEmpty ? '' : ' till $openTill',
              textStyle1: context.style.s12w700.copyWith(
                color: openTill.isEmpty
                    ? context.color.redColor
                    : context.color.greenColor,
              ),
              textStyle2: context.style.s12w700.copyWith(
                color: context.color.context.color.secondary.withValues(
                  alpha: 0.8,
                ),
              ),
            ),
            SvgAssets(Images.arrowBottomIc),
          ],
        ),
      ),
    );
  }
}

void showTimingSheet(List<Schedules> scheduleList) {
  Get.bottomSheet(RestaurantTimingSheet(scheduleList: scheduleList));
}

final dayList = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class RestaurantTimingSheet extends StatelessWidget {
  const RestaurantTimingSheet({super.key, required this.scheduleList});
  final List<Schedules> scheduleList;

  @override
  Widget build(BuildContext context) {
    return CommonSheet(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text('Restaurant timings', style: context.style.s24w700),
        ),
        ...dayList.map((e) {
          final isToday = dayList[DateTime.now().weekday - 1] == e;
          final data = scheduleList
              .firstWhereOrNull((ele) => dayList[(ele.day ?? 0) - 1] == e);
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isToday ? 'Today' : e,
                      style: context.style.s18w700.copyWith(
                        color: isToday
                            ? context.color.primary
                            : context.color.ff6c6c6c,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data == null
                          ? 'Closed'
                          : '${data.openingTime} - ${data.closingTime}',
                      style: context.style.s18w700.copyWith(
                        color: data == null
                            ? context.color.redColor
                            : isToday
                                ? context.color.primary
                                : context.color.ff6c6c6c,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: context.color.fff5f5f5, height: 24),
            ],
          );
        }),
      ],
    );
  }
}
