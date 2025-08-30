import 'package:scan_sa_user/common/enums/data_source_enum.dart';
import 'package:scan_sa_user/features/home/domain/models/advertisement_model.dart';
import 'package:scan_sa_user/interfaces/repository_interface.dart';

abstract class AdvertisementRepositoryInterface extends RepositoryInterface {
  @override
  Future<List<AdvertisementModel>?> getList({
    int? offset,
    DataSourceEnum source = DataSourceEnum.client,
  });
}
