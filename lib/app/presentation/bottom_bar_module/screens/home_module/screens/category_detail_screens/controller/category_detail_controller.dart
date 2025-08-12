import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/models/category_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/services/category_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';
import 'package:scan_sa_user/utils/extension/context_ext.dart';
import 'package:scan_sa_user/utils/extension/string_ext.dart';

class CategoryDetailController extends GetxController implements GetxService {
  CategoryDetailController(
    BuildContext context, {
    required this.categoryServiceInterface,
  }) {
    _tab = context.l10n.restaurants;
  }
  final CategoryServiceInterface categoryServiceInterface;

  List<CategoryModel> _subCategoryList = [];
  List<CategoryModel> get subCategoryList => _subCategoryList;

  List<Item> _categoryItemList = [];
  List<Item> get categoryItemList => _categoryItemList;

  List<Store> _categoryStoreList = [];
  List<Store> get categoryStoreList => _categoryStoreList;

  int _subCategoryIndex = 0;
  int get subCategoryIndex => _subCategoryIndex;

  String _type = 'all';
  String get type => _type;

  final bool _isStore = false;
  bool get isStore => _isStore;

  int _offset = 1;
  int get offset => _offset;

  final String _searchText = '';
  String? get searchText => _searchText;

  String _tab = '';
  String? get tab => _tab;

  final bool _isSearching = false;
  bool get isSearching => _isSearching;

  int? _pageSize;
  int? get pageSize => _pageSize;

  bool _isCategoryLoading = false;
  bool get isCategoryLoading => _isCategoryLoading;

  bool _isStoreLoading = false;
  bool get isStoreLoading => _isStoreLoading;

  bool _isItemLoading = false;
  bool get isItemLoading => _isItemLoading;

  int? _restPageSize;
  int? get restPageSize => _restPageSize;

  void changeTab(String value) {
    _tab = value;
    update();
  }

  Future<void> getSubCategoryList(String? categoryID) async {
    _isCategoryLoading = true;
    update();
    _subCategoryIndex = 0;
    _subCategoryList.clear();
    _categoryItemList.clear();
    final subCategoryList = await categoryServiceInterface.getSubCategoryList(
      categoryID,
    );
    _isCategoryLoading = false;
    update();
    if (subCategoryList != null) {
      _subCategoryList = [];
      _subCategoryList.add(
        CategoryModel(id: int.parse(categoryID!), name: 'all'.tr),
      );
      _subCategoryList.addAll(subCategoryList);
      await getCategoryItemList(categoryID, 1, 'all', false);
    }
  }

  void setSubCategoryIndex(int index, String? categoryID) {
    _subCategoryIndex = index;
    getCategoryStoreList(
      _subCategoryIndex == 0
          ? categoryID
          : _subCategoryList[index].id.toString(),
      1,
      _type,
      true,
    );
    getCategoryItemList(
      _subCategoryIndex == 0
          ? categoryID
          : _subCategoryList[index].id.toString(),
      1,
      _type,
      true,
    );
  }

  Future<void> getCategoryItemList(
    String? categoryID,
    int offset,
    String type,
    bool notify,
  ) async {
    _offset = offset;
    if (offset == 1) {
      _type = type;
      if (notify) {
        _isItemLoading = true;
        update();
      }
      _categoryItemList.clear();
    }
    final categoryItem = await categoryServiceInterface.getCategoryItemList(
      categoryID,
      offset,
      type,
    );
    ('====>>> object d ${categoryItem?.toJson()}').print;
    if (offset == 1) {
      _categoryItemList = [];
    }
    if (categoryItem?.items != null) {
      _categoryItemList.addAll(categoryItem!.items!);
      _pageSize = categoryItem.totalSize;
    }
    if (notify) {
      _isItemLoading = false;
    }
    ('==.. _categoryItemList ${_categoryItemList.length}').print;
    update();
  }

  Future<void> getCategoryStoreList(
    String? categoryID,
    int offset,
    String type,
    bool notify,
  ) async {
    _offset = offset;
    if (offset == 1) {
      _type = type;
      if (notify) {
        _isStoreLoading = true;
        update();
      }
      _categoryStoreList.clear();
    }
    final categoryStore = await categoryServiceInterface.getCategoryStoreList(
      categoryID,
      offset,
      type,
    );
    if (categoryStore != null) {
      final dummy = [..._categoryStoreList];
      if (offset == 1) {
        dummy.clear();
      }
      dummy.addAll(categoryStore.stores!);
      _categoryStoreList = dummy;
      ('===>>> _categoryStoreList ${_categoryStoreList.length}').print;
      _restPageSize = categoryStore.totalSize;
      _isStoreLoading = false;
    }
    update();
  }
}
