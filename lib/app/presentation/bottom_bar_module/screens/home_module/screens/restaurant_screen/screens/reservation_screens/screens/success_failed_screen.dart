import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/screens/reservation_screens/widgets/terms_condition_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/screens/restaurant_screen/widgets/call_sheet.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class SuccessFailedScreen extends StatefulWidget {
  const SuccessFailedScreen({super.key});

  @override
  State<SuccessFailedScreen> createState() => _SuccessFailedScreenState();
}

class _SuccessFailedScreenState extends State<SuccessFailedScreen> {
  bool isFailed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.fff5f5f5,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: AppButton(
              isBottomPad: true,
              buttonType: ButtonType.yellow,
              btnColor: context.color.secondary,
              label: isFailed ? 'Done' : 'Yay!',
              txtColor: const Color(0xFF600707),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          // padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(isFailed ? AppIcons.failedIc : AppIcons.successIc),
                Positioned(
                  bottom: 30,
                  child: Text(
                    isFailed ? 'Booking cancelled' : 'Your slot is booked!',
                    style: TextStyle(
                      color: isFailed
                          ? context.color.redColor
                          : context.color.greenColor,
                      fontSize: 50.sp,
                      fontFamily: 'MeowScript',
                    ),
                  ),
                ),
              ],
            ),

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
                    child: Column(
                      spacing: 25,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              [
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
                        if (!isFailed) directionWidget(context),
                      ],
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
                          child: DottedLine(
                            dashColor: context.color.borderColor,
                          ),
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
                    child: isFailed
                        ? directionWidget(context)
                        : Row(
                            spacing: 13,
                            children: [
                              SvgAssets(AppIcons.calenderIc),
                              Expanded(
                                child: Text(
                                  'Now reach at restaurant on the booked date and time',
                                  style: context.style.s16w700.copyWith(
                                    color: context.color.ff6c6c6c,
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
              padding: EdgeInsets.symmetric(horizontal: AppSizes.appPadding),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.color.secondary),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFFFAEF),
                    ),
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'View restaurant details',
                            style: context.style.s18w700.copyWith(
                              color: const Color(0xffe89200),
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 3,
                          child: SvgAssets(
                            AppIcons.arrowBottomIc,
                            color: const Color(0xffe89200),
                            height: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isFailed)
                    Divider(height: 40, color: context.color.borderColor),
                  if (!isFailed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Want to cancel your booking?',
                              style: context.style.s16w700.copyWith(
                                color: context.color.ff9c9c9c,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFailed = !isFailed;
                              });
                            },
                            child: Text(
                              'Cancel',
                              style: context.style.s16w700.copyWith(
                                color: context.color.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const TermsConditionWidget(),
          ],
        ),
      ),
    );
  }

  Widget directionWidget(BuildContext context) => Row(
    children: [
      Column(
        children: [
          Text(
            'Yam Chinese',
            style: context.style.s16w700.copyWith(
              color: context.color.ff6c6c6c,
            ),
          ),
          Text(
            'Riyadh, Dubai',
            style: context.style.s12w700.copyWith(
              color: context.color.ff9c9c9c,
            ),
          ),
        ],
      ),
      const Spacer(),
      Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: context.color.fff5f5f5,
        ),
        padding: const EdgeInsets.all(6),
        margin: const EdgeInsets.only(right: 8),
        child: SvgPicture.asset(AppIcons.directionIc),
      ),
      GestureDetector(
        onTap: showCallSheet,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.color.fff5f5f5,
          ),
          padding: const EdgeInsets.all(6),
          child: SvgPicture.asset(AppIcons.callIc),
        ),
      ),
    ],
  );
}
