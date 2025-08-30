import 'package:scan_sa_user/common/enums/data_source_enum.dart';
import 'package:scan_sa_user/features/brands/domain/models/brands_model.dart';
import 'package:scan_sa_user/features/item/domain/models/item_model.dart';
import 'package:scan_sa_user/interfaces/repository_interface.dart';

abstract class BrandsRepositoryInterface extends RepositoryInterface {
  Future<ItemModel?> getBrandItemList({required int brandId, int? offset});
  Future<List<BrandModel>?> getBrandList({required DataSourceEnum source});
}
