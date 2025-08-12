import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/update_user_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/userinfo_model.dart';
import 'package:scan_sa_user/common/models/response_model.dart';

abstract class ProfileServiceInterface {
  Future<UserInfoModel?> getUserInfo();
  //Future<ResponseModel> updateProfile(UserInfoModel userInfoModel, XFile? data, String token);
  Future<ResponseModel> updateProfile(
    UpdateUserModel userInfoModel,
    XFile? data,
    String token,
  );
  Future<ResponseModel> changePassword(UserInfoModel userInfoModel);
  Future<Response<dynamic>> deleteUser();
  Future<XFile?> pickImageFromGallery();
}
