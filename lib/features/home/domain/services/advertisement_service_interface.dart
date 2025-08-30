import 'package:scan_sa_user/common/enums/data_source_enum.dart';
import 'package:scan_sa_user/features/home/domain/models/advertisement_model.dart';

abstract class AdvertisementServiceInterface {
  Future<List<AdvertisementModel>?> getAdvertisementList(DataSourceEnum source);
}
