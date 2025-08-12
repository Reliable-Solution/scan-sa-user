import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassController extends GetxController {
  final passController = TextEditingController();
  final conPassController = TextEditingController();
  RxBool passObscureText = true.obs;
  RxBool conPassObscureText = true.obs;

  void toggleObscureText({bool isPass = true}) {
    if (isPass) {
      passObscureText.value = !passObscureText.value;
    } else {
      conPassObscureText.value = !conPassObscureText.value;
    }
  }
}
