import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/favorite_module/domain/repositories/favorite_repository_interface.dart';
import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/utils/app_constants.dart';

class FavoriteRepository implements FavoriteRepositoryInterface<ResponseModel> {
  FavoriteRepository({required this.apiClient});
  final ApiClient apiClient;

  @override
  Future<dynamic> getList({int? offset}) async {
    return apiClient.getData(AppConstants.wishListGetUri);
  }

  @override
  Future<ResponseModel> add(dynamic a, {bool isStore = false, int? id}) async {
    ResponseModel responseModel;
    final response = await apiClient.postData(
      '${AppConstants.addWishListUri}${isStore ? 'store_id=' : 'item_id='}$id',
      null,
      handleError: false,
    );
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message'] as String?);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> delete(int? id, {bool isStore = false}) async {
    ResponseModel responseModel;
    final response = await apiClient.deleteData(
      '${AppConstants.removeWishListUri}${isStore ? 'store_id=' : 'item_id='}$id',
      handleError: false,
    );
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body['message'] as String?);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<void> get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }
}
