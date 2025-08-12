import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/controllers/loyalty_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/loyalty/model/transaction_model.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/box_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class LoyaltyScreen extends StatefulWidget {
  const LoyaltyScreen({super.key, required this.fromNotification});
  final bool fromNotification;

  @override
  State<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends State<LoyaltyScreen> {
  final loyaltyController = Get.put(
    LoyaltyController(loyaltyServiceInterface: Get.find()),
  );
  @override
  void initState() {
    super.initState();
    initCall();
  }

  void initCall() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loyaltyController.getLoyaltyTransactionList('1', true);
      loyaltyController.setOffset(1);
    });
  }

  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return CommonSubAppBarScreen(
      title: 'Loyalty',
      bottomBtn: AppButton(
        label: 'Convert to Wallet money',
        isBottomPad: true,
        onPressed: () => loyaltyController.pointToWallet(500),
      ),
      child: GetBuilder<LoyaltyController>(
        builder: (loyaltyController) {
          return SmartRefresher(
            controller: refreshController,
            onRefresh: () {
              loyaltyController.getLoyaltyTransactionList('1', true);
              refreshController.refreshCompleted();
            },
            enablePullUp:
                !loyaltyController.isLoading &&
                loyaltyController.transactionList.isNotEmpty &&
                loyaltyController.offset <
                    (loyaltyController.popularPageSize! / 10).ceil(),
            onLoading: () {
              final pageSize = (loyaltyController.popularPageSize! / 10).ceil();
              if (loyaltyController.offset < pageSize) {
                loyaltyController.setOffset(loyaltyController.offset + 1);
                loyaltyController.showBottomLoader();
                loyaltyController.getLoyaltyTransactionList(
                  loyaltyController.offset.toString(),
                  false,
                );
              }
              refreshController.loadComplete();
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.appPadding,
                vertical: 10,
              ),
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.color.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        SvgAssets(AppIcons.loyaltyIc, height: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Convertible Points',
                              style: context.style.s12w700,
                            ),
                            Text(
                              Get.find<GlobalController>()
                                      .userInfoModel
                                      ?.loyaltyPoint
                                      ?.toString() ??
                                  '0',
                              style: context.style.s18w700,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // if (loyaltyController.isLoading ||
                //     loyaltyController.transactionList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Point History',
                    style: context.style.s18w700.copyWith(
                      color: context.color.primary,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: !loyaltyController.isLoading ? 10 : 10,
                  separatorBuilder: (context, index) => Divider(
                    color: context.color.darkTextGrey,
                    height: 30,
                  ).shimmer(context, isLoad: loyaltyController.isLoading),
                  itemBuilder: (context, index) {
                    final data = !loyaltyController.isLoading
                        ? Transaction()
                        : null;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: data == null ? 8 : 5,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Icon(
                                  Icons.stars_sharp,
                                  size: 15,
                                  color: context.color.secondary,
                                ).shimmer(context, isLoad: data == null),
                                if (data == null)
                                  const BoxShimmer(height: 14, width: 100)
                                else
                                  AppRichText(
                                    text1: '+500 ',
                                    text2: 'points',
                                    textStyle1: context.style.s16w700,
                                    textStyle2: context.style.s12w700.copyWith(
                                      color: context.color.ff6c6c6c,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),
                            if (data == null)
                              const BoxShimmer(height: 12, width: 100)
                            else
                              Text(
                                'Point to wallet',
                                style: context.style.s14w600.copyWith(
                                  color: context.color.ff6c6c6c,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: data == null ? 8 : 5,
                          children: [
                            if (data == null)
                              const BoxShimmer(height: 14, width: 80)
                            else
                              Text(
                                '2025-07-28 11:12 AM',
                                style: context.style.s14w600.copyWith(
                                  color: context.color.ff6c6c6c,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            if (data == null)
                              const BoxShimmer(height: 12, width: 50)
                            else
                              Text(
                                'Debit',
                                style: context.style.s14w600.copyWith(
                                  color: context.color.redColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
