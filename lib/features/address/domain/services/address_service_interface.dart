import 'package:scan_sa_user/common/models/response_model.dart';
import 'package:scan_sa_user/features/address/domain/models/address_model.dart';

abstract class AddressServiceInterface {
  Future<List<AddressModel>?> getAllAddress();
  Future<ResponseModel> removeAddressByID(int? id);
  Future<ResponseModel> addAddress(AddressModel addressModel);
  Future<ResponseModel> updateAddress(
    AddressModel addressModel,
    int? addressId,
  );
}
