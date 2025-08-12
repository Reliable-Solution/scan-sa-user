import 'package:scan_sa_user/api/api_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/profile_module/screens/join_as_delivery_store_module/domain/models/delivery_man_body.dart';
import 'package:scan_sa_user/helper/interfaces/repository_interface.dart';

abstract class DeliverymanRegistrationRepositoryInterface
    extends RepositoryInterface<dynamic> {
  @override
  Future<dynamic> getList({
    int? offset,
    int? zoneId,
    bool isZone = true,
    bool isVehicle = false,
  });
  Future<bool> registerDeliveryMan(
    DeliveryManBody deliveryManBody,
    List<MultipartBody> multiParts,
  );
}
