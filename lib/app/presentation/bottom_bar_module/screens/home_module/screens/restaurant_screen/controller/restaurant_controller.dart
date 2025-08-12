import 'package:get/get.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/category_domain/models/category_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/model/store_model.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/domains/store_domain/services/store_service_interface.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/home_module/provider/home_controller.dart';
import 'package:scan_sa_user/app/presentation/bottom_bar_module/screens/search_module/models/item_model.dart';

class RestaurantController extends GetxController {
  RestaurantController({required this.storeServiceInterface, this.store}) {
    getStoreItemList(storeID: store?.id, offset: 1, type: type, notify: true);
  }
  Store? store;
  final StoreServiceInterface storeServiceInterface;
  RxInt selectedCat = 0.obs;

  void selectCategory(int index) {
    selectedCat.value = index;
    getStoreItemList(storeID: store?.id, offset: 1, type: type, notify: true);
    update();
  }

  List<RxInt> cartDummyList = List.generate(10, (index) => 0.obs);

  void changeCartList(int index, bool isMinus) {
    if (isMinus) {
      cartDummyList[index].value--;
    } else {
      cartDummyList[index].value++;
    }
    update();
  }

  int get totalCartValue {
    var value = 0;
    for (final val in cartDummyList) {
      value += val.value;
    }
    return value;
  }

  ItemModel? _storeItemModel;
  ItemModel? get storeItemModel => _storeItemModel;

  String _type = 'all';
  String get type => _type;

  bool isItemLoad = false;

  Future<void> getStoreItemList({
    int? storeID,
    required int offset,
    required String type,
    bool notify = false,
  }) async {
    if (notify) {
      isItemLoad = true;
      update();
    }
    if (offset == 1 || _storeItemModel == null) {
      _type = type;
    }
    final storeItemModel = await storeServiceInterface.getStoreItemList(
      storeID,
      offset,
      selectedCat.value == 0 ? 0 : categoryList[selectedCat.value].id,
      type,
    );
    if (offset == 1 || _storeItemModel == null) {
      _storeItemModel = null;
    }
    if (storeItemModel != null) {
      setCategoryList();
      if (offset == 1) {
        _storeItemModel = storeItemModel;
      } else {
        _storeItemModel!.items!.addAll(storeItemModel.items!);
        _storeItemModel!.totalSize = storeItemModel.totalSize;
        _storeItemModel!.offset = storeItemModel.offset;
      }
    }
    isItemLoad = false;
    update();
  }

  List<CategoryModel> categoryList = [];
  void setCategoryList() {
    if ((Get.find<HomeController>().categoryList.value?.isNotEmpty ?? false) &&
        store != null) {
      categoryList = [];
      categoryList.add(CategoryModel(id: 0, name: 'All'.tr));
      for (final category
          in Get.find<HomeController>().categoryList.value ??
              <CategoryModel>[]) {
        if (store!.categoryIds!.contains(category.id)) {
          categoryList.add(category);
        }
      }
    }
  }
}
