// ignore_for_file: parameter_assignments

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';

class PriceConverter {
  static String convertPrice(
    num? price, {
    num? discount,
    String? discountType,
    bool forDM = false,
    bool isFoodVariation = false,
    String? formattedStringPrice,
    bool forTaxi = false,
  }) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount' && !isFoodVariation) {
        price = price! - discount;
      } else if (discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    final isRightSide =
        Get.find<GlobalController>().configModel!.currencySymbolDirection ==
        'right';

    if (forTaxi && price! > 100000) {
      return '${isRightSide ? '' : '${Get.find<GlobalController>().configModel!.currencySymbol!} '}'
          '${intl.NumberFormat.compact().format(price)}'
          '${isRightSide ? ' ${Get.find<GlobalController>().configModel!.currencySymbol!}' : ''}';
    }
    return '${isRightSide ? '' : '${Get.find<GlobalController>().configModel!.currencySymbol!} '}'
        '${formattedStringPrice ?? toFixed(price!).toStringAsFixed(forDM ? 0 : Get.find<GlobalController>().configModel!.digitAfterDecimalPoint!).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${isRightSide ? ' ${Get.find<GlobalController>().configModel!.currencySymbol!}' : ''}';
  }

  static Widget convertAnimationPrice(
    num? price, {
    num? discount,
    String? discountType,
    bool forDM = false,
    TextStyle? textStyle,
  }) {
    if (discount != null && discountType != null) {
      if (discountType == 'amount') {
        price = price! - discount;
      } else if (discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    final isRightSide =
        Get.find<GlobalController>().configModel!.currencySymbolDirection ==
        'right';
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedFlipCounter(
        duration: const Duration(milliseconds: 500),
        value: toFixed(price!),
        textStyle: textStyle,
        fractionDigits: forDM
            ? 0
            : Get.find<GlobalController>().configModel!.digitAfterDecimalPoint!,
        prefix: isRightSide
            ? ''
            : '${Get.find<GlobalController>().configModel!.currencySymbol!} ',
        suffix: isRightSide
            ? '${Get.find<GlobalController>().configModel!.currencySymbol!} '
            : '',
      ),
    );
  }

  static num? convertWithDiscount(
    num? price,
    num? discount,
    String? discountType, {
    bool isFoodVariation = false,
  }) {
    if (discountType == 'amount' && !isFoodVariation) {
      price = price! - discount!;
    } else if (discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static num calculation(num amount, num? discount, String type, int quantity) {
    num calculatedAmount = 0;
    if (type == 'amount' || type == 'fixed') {
      calculatedAmount = discount! * quantity;
    } else if (type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(
    String price,
    String discount,
    String discountType,
  ) {
    return '$discount${discountType == 'percent' ? '%' : Get.find<GlobalController>().configModel!.currencySymbol} OFF';
  }

  static num toFixed(num val) {
    final num mod = power(
      10,
      Get.find<GlobalController>().configModel!.digitAfterDecimalPoint!,
    );
    return (val * mod)
            .toDouble()
            .toPrecision(
              Get.find<GlobalController>().configModel!.digitAfterDecimalPoint!,
            )
            .floor() /
        mod;
  }

  static int power(int x, int n) {
    var retval = 1;
    for (var i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }
}
