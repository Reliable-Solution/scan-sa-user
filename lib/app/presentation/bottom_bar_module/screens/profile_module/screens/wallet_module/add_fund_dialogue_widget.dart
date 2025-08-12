import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/wallet_module/controllers/wallet_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/widgets/app_buttons.dart';
import 'package:scan_sa_user/app/widgets/app_rich_text.dart';
import 'package:scan_sa_user/app/widgets/app_text_field.dart';
import 'package:scan_sa_user/app/widgets/cache_image_network.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/utils/dimensions.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';

class AddFundDialogueWidget extends StatefulWidget {
  const AddFundDialogueWidget({super.key});

  @override
  State<AddFundDialogueWidget> createState() => _AddFundDialogueWidgetState();
}

class _AddFundDialogueWidgetState extends State<AddFundDialogueWidget> {
  final TextEditingController inputAmountController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     widget.cardScrollController.jumpTo(50);
    //   }
    // });

    Get.find<WalletController>().isTextFieldEmpty('', isUpdate: false);
    Get.find<WalletController>().changeDigitalPaymentName('', isUpdate: false);

    if (Get.find<GlobalController>()
            .configModel!
            .activePaymentMethodList!
            .length ==
        1) {
      Get.find<WalletController>().changeDigitalPaymentName(
        Get.find<GlobalController>()
            .configModel!
            .activePaymentMethodList!
            .first
            .getWay!,
        isUpdate: false,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: Get.back,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.color.whiteLight,
              ),
              padding: const EdgeInsets.all(3),
              child: Icon(Icons.clear, color: context.color.primary),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        GetBuilder<WalletController>(
          builder: (walletController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                color: context.color.whiteLight,
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 8),
                    child: Text(
                      'add_fund_to_wallet'.tr,
                      style: context.style.s24w700,
                    ),
                  ),
                  Text(
                    'add_fund_form_secured_digital_payment_gateways'.tr,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AppTextField(
                      hintText: 'enter_amount'.tr,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      controller: inputAmountController,
                      onChanged: (String value) {
                        _checkFormatters(value);
                        try {
                          if (num.parse(value) > 0) {
                            walletController.isTextFieldEmpty(value);
                          }
                        } catch (e) {
                          walletController.isTextFieldEmpty('');
                        }
                      },
                    ),
                  ),

                  AppRichText(
                    text1: '${'choose_payment_method'.tr} ',
                    text2: 'faster_and_secure_way_to_pay_bill'.tr,
                    textStyle2: context.style.s14w700.copyWith(
                      color: context.color.ff9c9c9c,
                    ),
                    textStyle1: context.style.s14w700,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        ListView.builder(
                          itemCount: Get.find<GlobalController>()
                              .configModel!
                              .activePaymentMethodList!
                              .length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final isSelected =
                                Get.find<GlobalController>()
                                    .configModel!
                                    .activePaymentMethodList![index]
                                    .getWay! ==
                                walletController.digitalPaymentName;
                            return InkWell(
                              onTap: () {
                                walletController.changeDigitalPaymentName(
                                  Get.find<GlobalController>()
                                      .configModel!
                                      .activePaymentMethodList![index]
                                      .getWay!,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Theme.of(
                                          context,
                                        ).primaryColor.withValues(alpha: 0.05)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusDefault,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall,
                                  vertical: Dimensions.paddingSizeLarge,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Colors.green
                                            : Theme.of(context).cardColor,
                                        border: Border.all(
                                          color: Theme.of(
                                            context,
                                          ).disabledColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Theme.of(context).cardColor,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Dimensions.paddingSizeDefault,
                                    ),
                                    CacheImageNetwork(
                                      '${Get.find<GlobalController>().configModel!.activePaymentMethodList![index].getWayImageFullUrl}',
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: Dimensions.paddingSizeSmall,
                                    ),
                                    Text(
                                      Get.find<GlobalController>()
                                          .configModel!
                                          .activePaymentMethodList![index]
                                          .getWayTitle!,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    ),
                  ),
                  AppButton(
                    label: 'add_fund'.tr,
                    onPressed: () => _onAddFundButtonClicked(walletController),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _checkFormatters(String value) {
    var test = value;
    if (value.contains('-')) {
      test = value.replaceAll('-', '');
    } else if (value.contains(' ')) {
      test = value.replaceAll(' ', '');
    } else if (value.contains(',')) {
      test = value.replaceAll(',', '');
    } else {
      test = value;
    }
    setState(() {
      inputAmountController.text = test;
      inputAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: test.length),
      );
    });
  }

  void _onAddFundButtonClicked(WalletController walletController) {
    if (inputAmountController.text.isEmpty) {
      showCustomSnackBar('please_provide_transfer_amount'.tr);
    } else if (inputAmountController.text == '0') {
      showCustomSnackBar('you_can_not_add_zero_amount_in_wallet'.tr);
    } else if (walletController.digitalPaymentName == '') {
      showCustomSnackBar('please_select_payment_method'.tr);
    } else {
      final amount = num.parse(
        inputAmountController.text.replaceAll(
          Get.find<GlobalController>().configModel!.currencySymbol!,
          '',
        ),
      );
      walletController.addFundToWallet(
        amount,
        walletController.digitalPaymentName!,
      );
    }
  }
}
