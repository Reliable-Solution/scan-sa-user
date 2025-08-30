import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:scan_sa_user/common/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/common/widgets/custom_button.dart';
import 'package:scan_sa_user/features/store/book_slot_screen/reservation_screens/widgets/terms_condition_widget.dart';
import 'package:scan_sa_user/util/app_sizes.dart';
import 'package:scan_sa_user/util/extension/context_ext.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSubAppBarScreen(
      title: 'Confirm Booking',
      bottomBtn: AppButton(
        buttonText: 'Book your slot',
        isBottomPad: true,
        color: context.color.greenColor,
        // onPressed: () => AppPages.successFailedScreen.push(),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: context.color.white,
            ),
            margin: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ('Saturday', '12 Jul 2025'),
                      ('Lunch', '12:30 AM'),
                      ('For 3', 'Guest'),
                    ]
                        .map(
                          (e) => Column(
                            children: [
                              Text(
                                e.$1,
                                style: context.style.s20w900.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                e.$2,
                                style: context.style.s14w700.copyWith(
                                  color: context.color.ff6c6c6c,
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Container(
                        height: 27,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: context.color.fff5f5f5,
                        ),
                      ),
                      Expanded(
                        child: DottedLine(dashColor: context.color.borderColor),
                      ),
                      Container(
                        height: 27,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          color: context.color.fff5f5f5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Yam Chinese',
                    style: context.style.s16w700.copyWith(
                      color: context.color.ff6c6c6c,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Riyadh, Dubai',
                    style: context.style.s12w700.copyWith(
                      color: context.color.ff9c9c9c,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const TermsConditionWidget(),
        ],
      ),
    );
  }
}
