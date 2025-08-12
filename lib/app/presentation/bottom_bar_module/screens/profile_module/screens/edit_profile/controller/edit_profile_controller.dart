import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/app_routes/app_pages.dart';
import 'package:scan_sa_user/app/presentation/auth_module/auth_repo/auth_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/cart_module/controller/cart_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/update_user_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/services/profile_service_interface.dart';
import 'package:scan_sa_user/app/presentation/main_screens/controller/global_controller.dart';
import 'package:scan_sa_user/app/presentation/main_screens/main_app.dart';
import 'package:scan_sa_user/app/widgets/custom_snackbar.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  EditProfileController({required this.profileServiceInterface}) {
    _notification = authServiceInterface.isSharedPrefNotificationActive();
  }
  final ProfileServiceInterface profileServiceInterface;
  final authServiceInterface = Get.find<AuthRepositoryInterface>();
  RxBool isDarkMode = true.obs;

  final nameController = TextEditingController();
  final gmailController = TextEditingController();
  final mobileController = TextEditingController();

  XFile? _pickedFile;
  XFile? get pickedFile => _pickedFile;

  Future<void> getUserInfo() async {
    _pickedFile = null;
    final userInfoModel = await profileServiceInterface.getUserInfo();
    if (userInfoModel != null) {
      Get.find<GlobalController>()
        ..userInfoModel = userInfoModel
        ..update();
    }
    update();
  }

  Future<ResponseModel> updateUserInfo({
    bool fromVerification = false,
    bool fromButton = false,
  }) async {
    if (fromButton) {
      EasyLoading.load();
    }
    final token = Get.find<AuthRepositoryInterface>().getUserToken();
    final updatedUser = UpdateUserModel(
      name: nameController.text,
      email: gmailController.text,
      phone: mobileController.text,
    );
    final responseModel = await profileServiceInterface.updateProfile(
      updatedUser,
      _pickedFile,
      token,
    );
    if (!fromVerification) {
      await _updateProfileResponseHandle(responseModel, updatedUser, token);
    }
    EasyLoading.dismiss();
    return responseModel;
  }

  Future<void> _updateProfileResponseHandle(
    ResponseModel responseModel,
    UpdateUserModel updateUserModel,
    String token,
  ) async {
    updateUserModel.verificationOn =
        responseModel.updateProfileResponseModel?.verificationOn;
    updateUserModel.verificationMedium =
        responseModel.updateProfileResponseModel?.verificationMedium;

    if (responseModel.isSuccess &&
        responseModel.updateProfileResponseModel != null &&
        responseModel.updateProfileResponseModel!.verificationOn != null &&
        responseModel.updateProfileResponseModel!.verificationOn! == 'phone') {
      if (responseModel.updateProfileResponseModel!.verificationMedium! ==
          'firebase') {
        await Get.find<GlobalController>().firebaseVerifyPhoneNumber(
          updateUserModel.phone!,
          token,
          '',
          fromSignUp: false,
          updateUserModel: updateUserModel,
        );
      } else {
        if (Get.isDialogOpen!) {
          Get.back();
        }

        // await Get.toNamed(
        //   RouteHelper.getVerificationRoute(
        //     updateUserModel.phone,
        //     null,
        //     '',
        //     '',
        //     null,
        //     '',
        //     updateUserModel: updateUserModel,
        //   ),
        // );
      }
    } else if (responseModel.isSuccess &&
        responseModel.updateProfileResponseModel != null &&
        responseModel.updateProfileResponseModel!.verificationOn != null &&
        responseModel.updateProfileResponseModel!.verificationOn! == 'email') {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    } else if (responseModel.isSuccess &&
        responseModel.updateProfileResponseModel == null) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      Get.back();
      await getUserInfo();
      _pickedFile = null;
      showCustomSnackBar(responseModel.message, isError: false);
    } else if (!responseModel.isSuccess &&
        responseModel.updateProfileResponseModel != null) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      showCustomSnackBar(responseModel.updateProfileResponseModel!.message);
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      showCustomSnackBar(responseModel.message);
    }
  }

  Future<void> pickImage() async {
    _pickedFile = await profileServiceInterface.pickImageFromGallery();
    update();
  }

  Future<void> deleteUser() async {
    EasyLoading.load();
    final response = await profileServiceInterface.deleteUser();
    if (response.statusCode == 200) {
      await authServiceInterface.clearSharedData(removeToken: false);
      await authServiceInterface.clearUserNumberAndPassword();
      await Get.find<CartController>().clearCartList();
      final email = Get.find<SharedPreferences>().getString('email');
      final pass = Get.find<SharedPreferences>().getString('pass');
      await Get.find<SharedPreferences>().clear();
      await Get.find<SharedPreferences>().setString('email', email ?? '');
      await Get.find<SharedPreferences>().setString('pass', pass ?? '');
      AppPages.login.offAll();
    } else {
      showCustomSnackBar('Unable to delete your account');
    }
    EasyLoading.dismiss();
    update();
  }

  bool _notification = true;
  bool get notification => _notification;

  Future<void> setNotificationActive() async {
    EasyLoading.load();
    await authServiceInterface.setNotificationActive(!_notification);
    _notification = authServiceInterface.isSharedPrefNotificationActive();
    update();
    EasyLoading.dismiss();
  }
}
