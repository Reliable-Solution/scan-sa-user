import 'package:scan_sa_user/common/enums/data_source_enum.dart';
import 'package:scan_sa_user/features/brands/domain/models/brands_model.dart';
import 'package:scan_sa_user/features/brands/domain/repositories/brands_repository_interface.dart';
import 'package:scan_sa_user/features/brands/domain/services/brands_service_interface.dart';
import 'package:scan_sa_user/features/item/domain/models/item_model.dart';

class BrandsService implements BrandsServiceInterface {
  BrandsService({required this.brandsRepositoryInterface});
  final BrandsRepositoryInterface brandsRepositoryInterface;

  @override
  Future<List<BrandModel>?> getBrandList(DataSourceEnum source) async {
    return brandsRepositoryInterface.getBrandList(source: source);
  }

  @override
  Future<ItemModel?> getBrandItemList({
    required int brandId,
    int? offset,
  }) async {
    return brandsRepositoryInterface.getBrandItemList(
      brandId: brandId,
      offset: offset,
    );
  }
}
