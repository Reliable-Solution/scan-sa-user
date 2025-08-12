import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/update_user_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/models/userinfo_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/repositories/profile_repository_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/domain/services/profile_service_interface.dart';
import 'package:scan_sa_user/common/models/response_model.dart';

class ProfileService implements ProfileServiceInterface {
  ProfileService({required this.profileRepositoryInterface});
  final ProfileRepositoryInterface profileRepositoryInterface;

  @override
  Future<UserInfoModel?> getUserInfo() async {
    return (await profileRepositoryInterface.get(null)) as UserInfoModel?;
  }

  /*  @override
  Future<ResponseModel> updateProfile(UserInfoModel userInfoModel, XFile? data, String token) async {
    return await profileRepositoryInterface.updateProfile(userInfoModel, data, token);
  }*/

  @override
  Future<ResponseModel> updateProfile(
    UpdateUserModel userInfoModel,
    XFile? data,
    String token,
  ) async {
    return profileRepositoryInterface.updateProfile(userInfoModel, data, token);
  }

  @override
  Future<ResponseModel> changePassword(UserInfoModel userInfoModel) async {
    return (await profileRepositoryInterface.changePassword(userInfoModel))
        as ResponseModel;
  }

  @override
  Future<Response<dynamic>> deleteUser() async {
    return (await profileRepositoryInterface.delete(null)) as Response<dynamic>;
  }

  @override
  Future<XFile?> pickImageFromGallery() async {
    XFile? pickedFile;
    final pickLogo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickLogo != null) {
      await pickLogo.length().then((value) {
        // if (value > 1000000) {
        //   showCustomSnackBar('please_upload_lower_size_file'.tr);
        // } else {
        pickedFile = pickLogo;
        // }
      });
    }
    return pickedFile;
  }
}
