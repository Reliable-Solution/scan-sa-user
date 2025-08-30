import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class AppValidations {
  AppValidations._();

  static String? emptyFieldValidation(String? value, String? error) {
    if (value?.isEmpty ?? true) {
      return error ?? 'this_field_is_required'.tr;
    }
    return null;
  }

  static String? passFieldValidation(String? value, BuildContext context) {
    if (value?.isEmpty ?? true) {
      return 'please_enter_password'.tr;
    } else if (value!.length <= 8) {
      return 'password_should_be_8_characters'.tr;
    } else {
      return null;
    }
  }

  static String? emailFieldValidation(String? value, BuildContext context) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final kEmailValid = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return 'please_enter_your_email'.tr;
    } else if (!kEmailValid.hasMatch(value.toString())) {
      return 'enter_email_address_or_phone_number'.tr;
    } else {
      return null;
    }
  }

  static Future<PhoneValid> isPhoneValid(String number) async {
    var phone = '';
    var countryCode = '';
    var isValid = true;
    try {
      final phoneNumber = PhoneNumber.parse(number);
      isValid = phoneNumber.isValid(type: PhoneNumberType.mobile);
      countryCode = phoneNumber.countryCode;
      if (isValid) {
        phone = '+${phoneNumber.countryCode}${phoneNumber.nsn}';
      }
    } catch (e) {
      debugPrint('Phone Number is not parsing: $e');
    }
    return PhoneValid(isValid: isValid, countryCode: countryCode, phone: phone);
  }
}

class PhoneValid {
  PhoneValid({
    required this.isValid,
    required this.countryCode,
    required this.phone,
  });
  bool isValid;
  String countryCode;
  String phone;
}
