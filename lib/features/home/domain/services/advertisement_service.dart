import 'package:scan_sa_user/common/enums/data_source_enum.dart';
import 'package:scan_sa_user/features/home/domain/models/advertisement_model.dart';
import 'package:scan_sa_user/features/home/domain/repositories/advertisement_repository_interface.dart';
import 'package:scan_sa_user/features/home/domain/services/advertisement_service_interface.dart';

class AdvertisementService implements AdvertisementServiceInterface {
  AdvertisementService({required this.advertisementRepositoryInterface});
  final AdvertisementRepositoryInterface advertisementRepositoryInterface;

  @override
  Future<List<AdvertisementModel>?> getAdvertisementList(
    DataSourceEnum source,
  ) async {
    return advertisementRepositoryInterface.getList(source: source);
  }
}
