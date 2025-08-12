import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/widgets/common_sheet.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

void showTimingSheet() {
  Get.bottomSheet(const RestaurantTimingSheet());
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
  const RestaurantTimingSheet({super.key});

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
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isToday ? 'Today' : e,
                      style: context.style.s18w700.copyWith(
                        color: isToday
                            ? context.color.secondary
                            : context.color.ff6c6c6c,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '11:30AM - 2AM',
                      style: context.style.s18w700.copyWith(
                        color: isToday
                            ? context.color.secondary
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
