import 'package:scan_sa_user/common/enums/data_source_enum.dart';
import 'package:scan_sa_user/interfaces/repository_interface.dart';

abstract class CampaignRepositoryInterface implements RepositoryInterface {
  @override
  Future getList({
    int? offset,
    bool isBasicCampaign = false,
    bool isItemCampaign = false,
    DataSourceEnum source,
  });
}
