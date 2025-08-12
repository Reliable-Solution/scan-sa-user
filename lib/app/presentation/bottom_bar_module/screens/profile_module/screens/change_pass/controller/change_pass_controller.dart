import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/services/profile_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';

class ChangePassController extends GetxController {
  ChangePassController({required this.profileServiceInterface});
  final ProfileServiceInterface profileServiceInterface;
  // final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  RxBool oldPassObscureText = true.obs;
  RxBool passObscureText = true.obs;
  RxBool conPassObscureText = true.obs;

  void toggleObscureText({bool? isPass = true}) {
    if (isPass == null) {
      oldPassObscureText.value = !oldPassObscureText.value;
    } else if (isPass) {
      passObscureText.value = !passObscureText.value;
    } else {
      conPassObscureText.value = !conPassObscureText.value;
    }
    update();
  }

  Future<void> changePassword() async {
    if (newPass.text.isEmpty) {
      showCustomSnackBar('Please enter new password');
      return;
    } else if (newPass.text != confirmPass.text) {
      showCustomSnackBar('New password and confirm password is not match');
      return;
    }
    final userModel = Get.find<GlobalController>().userInfoModel;
    userModel?.password = newPass.text;
    EasyLoading.load();
    final res = await profileServiceInterface.changePassword(userModel!);
    showCustomSnackBar(res.message, isError: false);
    Get.back();
    EasyLoading.dismiss();
  }
}
