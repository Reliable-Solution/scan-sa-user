import 'dart:async';

import 'package:get/get.dart';
import 'package:scan_sa_user/api/local_client.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/models/banner_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/banner_domain/services/banner_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/models/category_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/services/category_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/services/store_service_interface.dart';

class HomeController extends GetxController {
  HomeController({required this.storeServiceInterface}) {
    getData(isLoad: true);
  }
  final StoreServiceInterface storeServiceInterface;
  final bannerServiceInterface = Get.find<BannerServiceInterface>();
  final categoryServiceInterface = Get.find<CategoryServiceInterface>();

  final RxInt _selectedSort = 0.obs;
  RxInt get selectedSort => _selectedSort;
  void changeSortSelection(int sortIndex) {
    _selectedSort.value = sortIndex;
    getData(isLoad: true);
    Get.back();
  }

  final Rx<List<String?>?> _bannerImageList = Rx<List<String?>?>(null);
  Rx<List<String?>?> get bannerImageList => _bannerImageList;

  final Rx<List<dynamic>?> _bannerDataList = Rx<List<dynamic>?>(null);
  Rx<List<dynamic>?> get bannerDataList => _bannerDataList;

  Rx<List<CategoryModel>?> _categoryList = Rx<List<CategoryModel>?>(null);
  Rx<List<CategoryModel>?> get categoryList => _categoryList;
  RxBool isCategoryLoading = false.obs;

  final Rx<List<bool>?> _interestSelectedList = Rx<List<bool>?>(null);
  Rx<List<bool>?> get interestSelectedList => _interestSelectedList;

  Future<void> getData({bool isLoad = false, bool isHomeLoad = false}) async {
    if (isLoad || storeList.isEmpty) {
      isStoreLoad = true;
      storeList.clear();
      update();
    }
    if (isHomeLoad) unawaited(getCategoryList(isLoad));
    switch (selectedSort.value) {
      case 0:
        unawaited(getStoreList(1, isLoad));
      case 1:
        unawaited(getRecommendedStoreList(isLoad: isLoad));
      case 2:
        unawaited(getPopularStoreList('All'));
      case 3:
        unawaited(getStoreList(1, isLoad, sourceType: 'Top rated'));
      case 4:
        unawaited(getLatestStoreList('All'));
      default:
    }
    if (isLoad || storeList.isEmpty) {
      isStoreLoad = false;
    }
    unawaited(getBannerList(isLoad));
    update();
  }

  bool isBannerLoad = false;
  Future<void> getBannerList(
    bool reload, {
    DataSourceEnum dataSource = DataSourceEnum.local,
    bool fromRecall = false,
  }) async {
    isBannerLoad = true;
    update();
    try {
      if (_bannerImageList.value == null || reload || fromRecall) {
        if (reload) {
          _bannerImageList.value = null;
        }
        BannerModel? bannerModel;
        // if (dataSource == DataSourceEnum.local) {
        //   bannerModel = await bannerServiceInterface.getBannerList(
        //     source: DataSourceEnum.local,
        //   );
        //   await _prepareBanner(bannerModel);

        //   await getBannerList(
        //     false,
        //     dataSource: DataSourceEnum.client,
        //     fromRecall: true,
        //   );
        // } else {
        bannerModel = await bannerServiceInterface.getBannerList(
          source: DataSourceEnum.client,
        );
        await _prepareBanner(bannerModel);
        // }
      }
    } finally {
      isBannerLoad = false;
      update();
    }
  }

  Future<void> _prepareBanner(BannerModel? bannerModel) async {
    if (bannerModel != null) {
      _bannerImageList.value = [];
      _bannerDataList.value = [];
      for (final campaign in bannerModel.campaigns!) {
        if (_bannerImageList.value!.contains(campaign.imageFullUrl)) {
          _bannerImageList.value?.add(
            '${campaign.imageFullUrl}${bannerModel.campaigns!.indexOf(campaign)}',
          );
        } else {
          _bannerImageList.value?.add(campaign.imageFullUrl);
        }
        _bannerDataList.value?.add(campaign);
      }
      for (final banner in bannerModel.banners!) {
        if (_bannerImageList.value?.contains(banner.imageFullUrl) ?? false) {
          _bannerImageList.value?.add(
            '${banner.imageFullUrl}${bannerModel.banners!.indexOf(banner)}',
          );
        } else {
          _bannerImageList.value?.add(banner.imageFullUrl);
        }

        if (banner.item != null) {
          _bannerDataList.value?.add(banner.item);
        } else if (banner.store != null) {
          _bannerDataList.value?.add(banner.store);
        } else if (banner.type == 'default') {
          _bannerDataList.value?.add(banner.link);
        } else {
          _bannerDataList.value?.add(null);
        }
      }
    }
    update();
  }

  Future<void> getCategoryList(
    bool reload, {
    bool allCategory = false,
    DataSourceEnum dataSource = DataSourceEnum.local,
    bool fromRecall = false,
  }) async {
    isCategoryLoading.value = true;
    update();
    if (_categoryList.value == null || reload || fromRecall) {
      if (reload) {
        _categoryList = Rx<List<CategoryModel>?>(null);
      }
      List<CategoryModel>? categoryList;
      if (dataSource == DataSourceEnum.local) {
        categoryList =
            await categoryServiceInterface.getCategoryList(
                  allCategory,
                  source: DataSourceEnum.local,
                )
                as List<CategoryModel>?;

        _prepareCategoryList(categoryList);
        await getCategoryList(
          false,
          fromRecall: true,
          allCategory: allCategory,
          dataSource: DataSourceEnum.client,
        );
      } else {
        categoryList =
            await categoryServiceInterface.getCategoryList(
                  allCategory,
                  source: DataSourceEnum.client,
                )
                as List<CategoryModel>?;
        _prepareCategoryList(categoryList);
      }
    }
  }

  void _prepareCategoryList(List<CategoryModel>? categoryList) {
    if (categoryList != null) {
      _categoryList.value = [];
      _interestSelectedList.value = [];
      _categoryList.value?.addAll(categoryList);
      for (var i = 0; i < (_categoryList.value?.length ?? 0); i++) {
        _interestSelectedList.value?.add(false);
      }
    }
    isCategoryLoading.value = false;
    update();
  }

  RxList<Store> storeList = <Store>[].obs;

  final String _filterType = 'all';
  String get filterType => _filterType;

  final String _storeType = 'all';
  String get storeType => _storeType;

  int totalStoreSize = 0;
  int storeOffset = 0;

  bool isStoreLoad = false;

  Future<void> getStoreList(
    int offset,
    bool reload, {
    String? sourceType,
    DataSourceEnum source = DataSourceEnum.local,
  }) async {
    if (reload) {
      isStoreLoad = true;
      storeList.clear();
      update();
    }
    StoreModel? storeModel;
    storeModel = await storeServiceInterface.getStoreList(
      offset,
      _filterType,
      sourceType ?? 'All',
      source: DataSourceEnum.local,
    );
    _prepareStoreModel(storeModel, offset);
  }

  void _prepareStoreModel(StoreModel? storeModel, int offset) {
    if (storeModel != null) {
      if (offset == 1) {
        storeList.value = [...storeModel.stores ?? <Store>[]];
      } else {
        totalStoreSize = storeModel.totalSize ?? 0;
        storeOffset = storeModel.offset ?? 1;
        final list = [...storeList];
        list.addAll(storeModel.stores ?? []);
        storeList.value = list;
      }
    }
    isStoreLoad = false;
    update();
  }

  Future<void> getPopularStoreList(String type) async {
    List<Store>? popularStoreList;
    popularStoreList = await storeServiceInterface.getPopularStoreList(
      type,
      source: DataSourceEnum.client,
    );
    if (popularStoreList != null) {
      storeList.clear();
      storeList.addAll(popularStoreList);
    }
  }

  Future<void> getLatestStoreList(String type) async {
    List<Store>? latestStoreList;

    latestStoreList = await storeServiceInterface.getLatestStoreList(
      type,
      source: DataSourceEnum.client,
    );
    if (latestStoreList != null) {
      storeList.value = [];
      storeList.addAll(latestStoreList);
    }
    update();
  }

  Future<void> getRecommendedStoreList({bool isLoad = false}) async {
    storeList.value =
        await storeServiceInterface.getRecommendedStoreList(
          source: DataSourceEnum.client,
        ) ??
        [];
  }

  @override
  void onInit() {
    getCategoryList(true);
    super.onInit();
  }
}
