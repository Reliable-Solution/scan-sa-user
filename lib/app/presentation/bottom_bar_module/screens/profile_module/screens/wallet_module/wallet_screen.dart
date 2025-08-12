import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/add_fund_dialogue_widget.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/controllers/wallet_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_image_widget.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/common_sub_screen.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/box_shimmer.dart';
import 'package:scan_sa_user/app/widgets/shimmer_widgets/shimmer_ext.dart';
import 'package:scan_sa_user/helper/date_converter.dart';
import 'package:scan_sa_user/helper/price_converter.dart';
import 'package:scan_sa_user/utils/app_icons.dart';
import 'package:scan_sa_user/utils/app_sizes.dart';
import 'package:scan_sa_user/utils/app_strings.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final walletController = Get.put(
    WalletController(walletServiceInterface: Get.find()),
  );
  final smartRefresher = RefreshController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      walletController.getWalletTransactionList('1', true, 'all');
    });
    super.initState();
  }

  // void initCall() {
  //   if (AuthHelper.isLoggedIn()) {
  //     Get.find<WalletController>().insertFilterList();
  //     Get.find<WalletController>().setWalletFilerType('all', isUpdate: false);

  //     if ((widget.fundStatus == 'success' ||
  //             widget.fundStatus == 'fail' ||
  //             widget.fundStatus == 'cancel') &&
  //         Get.find<WalletController>().getWalletAccessToken() != widget.token) {
  //       Future.delayed(const Duration(seconds: 2), () {
  //         Get.showSnackbar(
  //           GetSnackBar(
  //             backgroundColor:
  //                 widget.fundStatus == 'fail' || widget.fundStatus == 'cancel'
  //                 ? Colors.red
  //                 : Colors.green,
  //             message: widget.fundStatus == 'success'
  //                 ? 'fund_successfully_added_to_wallet'.tr
  //                 : 'fund_not_added_to_wallet'.tr,
  //             maxWidth: 500,
  //             duration: const Duration(seconds: 3),
  //             margin: const EdgeInsets.all(Dimensions.paddingSizeExtremeLarge),
  //             borderRadius: Dimensions.radiusExtraLarge,
  //             dismissDirection: DismissDirection.horizontal,
  //           ),
  //         );
  //       }).then((value) {
  //         Get.find<WalletController>().setWalletAccessToken(widget.token ?? '');
  //       });
  //     }

  //     Get.find<WalletController>().getWalletBonusList(isUpdate: false);

  //     Get.find<WalletController>().getWalletTransactionList(
  //       '1',
  //       false,
  //       Get.find<WalletController>().type,
  //     );

  //     Get.find<WalletController>().setOffset(1);

  //     scrollController.addListener(() {
  //       if (scrollController.position.pixels ==
  //               scrollController.position.maxScrollExtent &&
  //           !Get.find<WalletController>().isLoading) {
  //         final pageSize = (Get.find<WalletController>().popularPageSize! / 10)
  //             .ceil();
  //         if (Get.find<WalletController>().offset < pageSize) {
  //           Get.find<WalletController>().setOffset(
  //             Get.find<WalletController>().offset + 1,
  //           );
  //           if (kDebugMode) {
  //             debugPrint('end of the page');
  //           }
  //           Get.find<WalletController>().showBottomLoader();
  //           Get.find<WalletController>().getWalletTransactionList(
  //             Get.find<WalletController>().offset.toString(),
  //             false,
  //             Get.find<WalletController>().type,
  //           );
  //         }
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (walletController) {
        final entryList = <PopupMenuEntry<int>>[];
        var filterName = '';

        for (var i = 0; i < walletController.walletFilterList.length; i++) {
          entryList.add(
            PopupMenuItem<int>(
              value: i,
              child: Text(
                walletController.walletFilterList[i].title!.tr,
                style: context.style.s14w600.copyWith(
                  color:
                      walletController.walletFilterList[i].value ==
                          walletController.type
                      ? context.color.primary
                      : context.color.darkTextGrey,
                ),
              ),
            ),
          );
          if (walletController.walletFilterList[i].value ==
              walletController.type) {
            filterName = walletController.walletFilterList[i].title!.tr;
          } else if (walletController.type == 'all') {
            filterName = '';
          }
        }
        return CommonSubAppBarScreen(
          title: 'Wallet',
          child: SmartRefresher(
            controller: smartRefresher,
            onRefresh: () {
              walletController.getWalletTransactionList(
                '1',
                true,
                walletController.type,
              );
              smartRefresher.refreshCompleted();
            },
            enablePullUp:
                !walletController.isLoading &&
                walletController.transactionList.isNotEmpty &&
                walletController.offset <
                    (walletController.popularPageSize! / 10).ceil(),
            onLoading: () {
              final pageSize = (walletController.popularPageSize! / 10).ceil();
              if (walletController.offset < pageSize) {
                walletController.setOffset(walletController.offset + 1);
                walletController.showBottomLoader();
                walletController.getWalletTransactionList(
                  walletController.offset.toString(),
                  false,
                  walletController.type,
                );
              }
              smartRefresher.loadComplete();
            },
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.appPadding,
                vertical: 16,
              ),
              children: [
                SvgAssets(AppIcons.walletVector, width: 200),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: context.color.secondary,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wallet Amount',
                                style: context.style.s14w700.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${Get.find<GlobalController>().userInfoModel?.walletBalance?.toString() ?? '0'}'
                                ' ${AppStrings.dinar}',
                                style: context.style.s30w700.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          if (Get.find<GlobalController>()
                                  .configModel
                                  ?.activePaymentMethodList
                                  ?.isNotEmpty ??
                              false)
                            GestureDetector(
                              onTap: () {
                                Get.dialog(
                                  const Dialog(
                                    backgroundColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    child: AddFundDialogueWidget(),
                                  ),
                                );
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: context.color.primary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    'Add',
                                    style: context.style.s14w700.copyWith(
                                      color: context.color.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wallet History',
                          style: context.style.s18w700.copyWith(
                            color: context.color.primary,
                          ),
                        ),
                        if (filterName.isNotEmpty)
                          Text(
                            filterName,
                            style: context.style.s14w600.copyWith(
                              color: context.color.ff6c6c6c,
                            ),
                          ),
                      ],
                    ),
                    PopupMenuButton<int>(
                      offset: const Offset(-20, 20),
                      itemBuilder: (BuildContext context) => entryList,
                      onSelected: (int value) {
                        walletController.setWalletFilerType(
                          walletController.walletFilterList[value].value!,
                        );
                        walletController.getWalletTransactionList(
                          '1',
                          false,
                          walletController.type,
                        );
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.color.borderColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.paddingSizeSmall,
                            right: Dimensions.paddingSizeExtraSmall,
                            top: 2,
                            bottom: 2,
                          ),
                          child: Row(
                            children: [
                              Text('filter'.tr, style: context.style.s14w600),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 18,
                                color: context.color.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: walletController.isLoading
                      ? 10
                      : walletController.transactionList.length,
                  separatorBuilder: (context, index) => Divider(
                    color: context.color.darkTextGrey,
                    height: 30,
                  ).shimmer(context, isLoad: walletController.isLoading),
                  itemBuilder: (context, index) {
                    final data = !walletController.isLoading
                        ? walletController.transactionList[index]
                        : null;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: data == null ? 8 : 5,
                          children: [
                            Builder(
                              builder: (context) {
                                final debit =
                                    data?.transactionType == 'order_place' ||
                                    data?.transactionType == 'partial_payment';
                                return Row(
                                  spacing: 5,
                                  children: [
                                    Icon(
                                      Icons.monetization_on_outlined,
                                      size: 15,
                                      color: debit
                                          ? context.color.secondary
                                          : context.color.greenColor,
                                    ).shimmer(context, isLoad: data == null),
                                    if (data == null)
                                      const BoxShimmer(height: 14, width: 100)
                                    else
                                      AppRichText(
                                        text1: debit
                                            ? '- ${PriceConverter.convertPrice(data.debit! + data.adminBonus!)}'
                                            : '+ ${PriceConverter.convertPrice(data.credit! + data.adminBonus!)}',
                                        text2: '',
                                        textStyle1: context.style.s16w700,
                                        textStyle2: context.style.s12w700
                                            .copyWith(
                                              color: context.color.ff6c6c6c,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            if (data == null)
                              const BoxShimmer(height: 12, width: 100)
                            else
                              Text(
                                data.transactionType == 'add_fund'
                                    ? '${'added_via'.tr} ${data.reference!.replaceAll('_', ' ')} ${data.adminBonus != 0 ? '(${'bonus'.tr} = ${data.adminBonus})' : ''}'
                                    : data.transactionType == 'partial_payment'
                                    ? '${'spend_on_order'.tr} # ${data.reference}'
                                    : data.transactionType == 'loyalty_point'
                                    ? 'converted_from_loyalty_point'.tr
                                    : data.transactionType == 'referrer'
                                    ? 'earned_by_referral'.tr
                                    : data.transactionType == 'order_place'
                                    ? '${'order_place'.tr} # ${data.reference}'
                                    : data.transactionType!.tr,
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
                                DateConverter.dateToDateAndTimeAm(
                                  data.createdAt!,
                                ),
                                style: context.style.s14w600.copyWith(
                                  color: context.color.ff6c6c6c,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            if (data == null)
                              const BoxShimmer(height: 12, width: 50)
                            else
                              Text(
                                data.transactionType == 'order_place' ||
                                        data.transactionType ==
                                            'partial_payment'
                                    ? 'debit'.tr
                                    : 'credit'.tr,
                                style: context.style.s14w600.copyWith(
                                  color:
                                      data.transactionType == 'order_place' ||
                                          data.transactionType ==
                                              'partial_payment'
                                      ? context.color.redColor
                                      : context.color.greenColor,
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
          ),
        );
      },
    );
  }
}
