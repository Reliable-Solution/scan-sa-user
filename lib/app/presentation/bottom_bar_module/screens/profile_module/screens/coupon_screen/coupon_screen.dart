import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/coupon_screen/controllers/coupon_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/box_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final couponController = Get.put(
    CouponController(couponServiceInterface: Get.find()),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      couponController.getCouponList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final refreshController = RefreshController();
    return CommonSubAppBarScreen(
      title: 'Coupon',
      child: GetBuilder<CouponController>(
        builder: (couponController) {
          return SmartRefresher(
            controller: refreshController,
            onRefresh: () {
              couponController.getCouponList();
              refreshController.refreshCompleted();
            },
            child: const VoucherScreenWidget(),
          );
        },
      ),
    );
  }
}

class VoucherScreenWidget extends StatelessWidget {
  const VoucherScreenWidget({super.key, this.onTap});
  final void Function(String code)? onTap;

  @override
  Widget build(BuildContext context) {
    final couponController = Get.find<CouponController>();
    return couponController.couponList.isEmpty && !couponController.isCouponLoad
        ? const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text('No Coupon Found'),
            ),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: MediaQuery.sizeOf(context).width * .00148,
              crossAxisSpacing: 20,
            ),
            padding: EdgeInsets.all(AppSizes.appPadding),
            itemCount: couponController.isCouponLoad
                ? 10
                : couponController.couponList.length,
            itemBuilder: (context, index) {
              final coupon = couponController.isCouponLoad
                  ? null
                  : couponController.couponList[index];
              final isFreeDelivery = coupon?.couponType == 'free_delivery';
              return GestureDetector(
                onTap: onTap != null
                    ? () => onTap?.call(coupon?.code ?? '')
                    : () {
                        if (coupon?.code?.isNotEmpty ?? false) {
                          Clipboard.setData(
                            ClipboardData(text: coupon?.code ?? ''),
                          );
                          Get.snackbar(
                            'Copied!',
                            'Text copied to clipboard.',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.color.white,
                      ),
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.only(top: 45),
                      child: Column(
                        children: [
                          if (coupon == null)
                            const BoxShimmer(height: 12, width: 80)
                          else
                            Text(
                              isFreeDelivery
                                  ? 'Free Delivery'
                                  : '${coupon.discount} '
                                        '${coupon.discountType == 'percentage' ? "%" : AppStrings.dinar}',
                              style: context.style.s16w700,
                            ),
                          if (coupon == null)
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: BoxShimmer(height: 8),
                            )
                          else
                            Text(
                              coupon.store == null
                                  ? coupon.couponType == 'store_wise'
                                        ? '${'on'.tr} ${coupon.data}'
                                        : 'On all store'
                                  : '${'on'.tr} ${coupon.store?.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.style.s12w700.copyWith(
                                color: context.color.ff6c6c6c,
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
                                    color: Get.find<GlobalController>().isDark
                                        ? context.color.whiteLight
                                        : context.color.fff5f5f5,
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
                                    color: Get.find<GlobalController>().isDark
                                        ? context.color.whiteLight
                                        : context.color.fff5f5f5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (coupon == null)
                            const BoxShimmer(height: 25, width: 80, radius: 5)
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                coupon.title ?? '',
                                style: context.style.s22w700,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          if (coupon == null)
                            const Padding(
                              padding: EdgeInsets.only(top: 14, bottom: 5),
                              child: BoxShimmer(height: 12, width: 120),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                '${DateFormat('dd MMM, yyyy').format(DateTime.parse(coupon.startDate ?? DateTime.now().toString()))}'
                                ' TO\n${DateFormat('dd MMM, yyyy').format(DateTime.parse(coupon.expireDate ?? DateTime.now().toString()))}',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: context.style.s12w700.copyWith(
                                  color: context.color.ff6c6c6c,
                                ),
                              ),
                            ),
                          if (coupon == null)
                            const BoxShimmer(height: 12, width: 80),
                          if (coupon == null)
                            const Padding(
                              padding: EdgeInsets.only(top: 14, bottom: 8),
                              child: BoxShimmer(height: 12, width: 80),
                            )
                          else
                            Text(
                              '*MIN PURCHASE\n${coupon.minPurchase} ${AppStrings.dinar}',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: context.style.s12w700.copyWith(
                                color: context.color.ff9c9c9c,
                              ),
                            ),
                          if (coupon == null)
                            const BoxShimmer(height: 10, width: 120),
                        ],
                      ),
                    ),
                    Image.asset(
                      coupon?.discountType == 'percent'
                          ? AppIcons.percentage
                          : coupon?.couponType == 'free_delivery'
                          ? AppIcons.delivery
                          : AppIcons.money,
                    ).shimmer(context, isLoad: coupon == null),
                  ],
                ),
              );
            },
          );
  }
}
